class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_accessor :shopping_list
  attr_reader :leftovers
  include Formattable
  # before_save :normalize

  def create_shopping_list
    
    self.ingredients.each do |i| 
      @shopping_list ||= {}
      shopping_list[i.name] ||= Hash.new(0)
      shopping_list[i.name][:quantity] += i.quantity
      shopping_list[i.name][:measurement] = i.measurement.pluralize
      if shopping_list[i.name][:quantity] <= 1
        shopping_list[i.name][:measurement] = ("A "+i.measurement.singularize)  
      end
    end
    self.shopping_list= @shopping_list
    self.save
  end

  def create_recipes_and_ingredients(array_list)
  	info = format(array_list)
  	info.each do |recipe_hash|
  		new_recipe = self.recipes.build(recipe_hash[:recipe])
  		recipe_hash[:ingredients].each do |ingredient_hash|
  			new_recipe.ingredients.build(ingredient_hash)
  		end
  		new_recipe.save
  	end
  end

  # @@raw_ignores = ['box','pinch']
  # @@ignores = []

# ONLY GOING TO NORMALIZE IF > 1 , fixes problem with A
  # private
  # def normalize
  #   if self.persisted?
  #     create_ignored_list(@@raw_ignores)
  #     self.shopping_list.each do |name, attrs|
  #       unless @@ignores.include?(attrs[:measurement])
  #         self.shopping_list[name][:normalized] = Measurement.parse("#{attrs[:quantity]} #{attrs[:measurement]}")
  #       end
  #     end
  #   end
  # end

  # def create_ignored_list(ary)
  #   ary.each do |term|
  #     @@ignores << term
  #     @@ignores << term.pluralize
  #   end
  # end

end