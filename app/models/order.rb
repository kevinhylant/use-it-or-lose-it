class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_reader :leftovers
  include Formattable

  def render_recipes(leftovers)
    array_list = leftovers.split(/\s*,\s*/)
    self.format(array_list)  
  end
 
end