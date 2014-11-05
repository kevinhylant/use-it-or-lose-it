class Order < ActiveRecord::Base 
  has_many :recipes
  has_many :ingredients, :through => :recipes
  attr_reader :leftovers

  include Formattable
 
end