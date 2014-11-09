class Order < ActiveRecord::Base
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_accessor :shopping_list
  attr_reader :leftovers
  include Formattable

  def create_shopping_list
    self.ingredients.each do |i|
      @shopping_list ||= {}
      shopping_list[i.name] ||= Hash.new
      @normalized = i.to_ounces
      add_like_ingredients_together_and_pre_format_for_erb(i)
    end
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

  def add_like_ingredients_together_and_pre_format_for_erb(i)
    if @normalized != ''
      shopping_list[i.name][:measurement] = i.measurement
      if shopping_list[i.name][:normalized] == nil
        shopping_list[i.name][:normalized] = @normalized
      else
        shopping_list[i.name][:normalized] += @normalized
      end
    elsif !i.has_nil_or_zero_quantity? && !i.has_nil_or_zero_measurement? && !i.has_normal_measurement? # has quantity & measurement but has an abnormal measurement
      shopping_list[i.name][:measurement] = i.measurement
      if i.quantity > 1
        shopping_list[i.name][:normalized] = "#{i.quantity} #{i.measurement.pluralize}"
      else
        shopping_list[i.name][:normalized] = "#{i.quantity} #{i.measurement.singularize}"
      end
    elsif !i.has_nil_or_zero_quantity? && i.has_nil_or_zero_measurement?    # has quantity, but no measurement
      shopping_list[i.name][:normalized] = i.quantity
      shopping_list[i.name][:measurement] = ''
    elsif !i.has_nil_or_zero_measurement? && i.has_nil_or_zero_quantity?    # has measurement, but no quantity
      i.convert_to_long_form_normal_measurement
      shopping_list[i.name][:normalized] = "A #{i.measurement.singularize}"
      shopping_list[i.name][:measurement] = i.measurement
    elsif i.has_nil_or_zero_quantity? && i.has_nil_or_zero_measurement?     # no quantity & no measurement
      shopping_list[i.name][:normalized] = ""
      shopping_list[i.name][:measurement] = ''
    end
  end

end
