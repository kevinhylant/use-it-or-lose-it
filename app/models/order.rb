class Order < ActiveRecord::Base
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_accessor :shopping_list
  attr_reader :leftovers
  include Formattable

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

  def create_shopping_list
    self.ingredients.each do |i|

      @shopping_list ||= {}  
      shopping_list[i.name] ||= Hash.new  #Adds hash keys for each unique ingredient

      @normalized = i.to_ounces           #Converts those with normal measurements

      combine_ingredients_and_format_for_erb(i) 
    end
  end

  def combine_ingredients_and_format_for_erb(i)
    current_ingredient = self.shopping_list[i.name]

    if i.normal_measurement? && !i.missing_quantity?
      
      current_ingredient[:measurement]  = i.measurement
      current_ingredient[:normalized]  += @normalized  if current_ingredient[:normalized] != nil
      current_ingredient[:normalized] ||= @normalized
 
    elsif !i.normal_measurement? && !i.missing_measurement? && !i.missing_quantity?
      current_ingredient[:measurement] = i.measurement
      if i.quantity > 1
        current_ingredient[:normalized] = "#{i.quantity} #{i.measurement.pluralize}"
      else
        current_ingredient[:normalized] = "#{i.quantity} #{i.measurement.singularize}"
      end

    elsif i.missing_measurement? && !i.missing_quantity?
      current_ingredient[:measurement] = ''
      current_ingredient[:normalized] = i.quantity

    elsif i.missing_quantity? && !i.missing_measurement?
      i.convert_measurement_to_long_form
      current_ingredient[:measurement] = i.measurement
      current_ingredient[:normalized] = "A #{i.measurement.singularize}"

    elsif i.missing_measurement? && i.missing_quantity?
      current_ingredient[:normalized] = ''
      current_ingredient[:measurement] = ''
    end
  end

end
