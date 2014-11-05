class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_reader :leftovers

  def leftovers=(names)
    @leftovers = names.split(/\s*,\s*/)
  end
 
end