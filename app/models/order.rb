class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_accessor :shopping_list
  attr_reader :leftovers
  include Formattable
  before_save :normalize


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

  @@raw_ignores = ['box','pinch']
  @@ignores = []


  private
  def normalize
    if self.persisted?
      create_ignored_list(@@raw_ignores)
      self.shopping_list.each do |name, attrs|
        if @@ignores.include?(attrs[:measurement])
          self.shopping_list[name][:normalized] = ("#{attrs[:quantity]} #{attrs[:measurement]}") 
        elsif attrs[:quantity] <= 1
          shopping_list[name][:normalized] = (attrs[:measurement]) 
        else
          shopping_list[name][:normalized] = Measurement.parse("#{attrs[:quantity]} #{attrs[:measurement]}")
          ing_measurement = attrs[:normalized].unit
          if is_weight?(ing_measurement.to_s)
            shopping_list[name][:normalized]= attrs[:normalized].convert_to(:oz)
          elsif is_volume?(ing_measurement.to_s)
            shopping_list[name][:normalized]= attrs[:normalized].convert_to(:'fl oz')
          end
        end
      end
    end
  end

  def create_ignored_list(ary)
    ary.each do |term|
      @@ignores << term
      @@ignores << term.pluralize
    end
  end

  def is_weight?(obj)
    weight_types = ['lb','oz']
    weight_types.include?(obj)
  end

  def is_volume?(obj)
    vol_types = ['gal','qt','pt','c.','fl. oz.','tbsp.','tsp.']
    vol_types.include?(obj)
  end


end