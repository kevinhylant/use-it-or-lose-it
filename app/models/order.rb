class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_accessor :shopping_list
  attr_reader :leftovers
  include Formattable

  def create_shopping_list
  
    @shopping_list = Hash.new(0)
    self.ingredients.each do |i| 
      @shopping_list[i.name] += i.quantity
    end
    
    self.shopping_list= @shopping_list
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
end