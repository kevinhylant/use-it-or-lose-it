class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  before_save :normalize

  def abnormal_measurement?
    MEASUREMENT_INDEX.keys.include?(self.measurement.downcase)
  end

  private
  def normalize
    self.measurement= (MEASUREMENT_INDEX[measurement]) if self.abnormal_measurement?
  end

end

MEASUREMENT_INDEX = {
  'c'   => 'cup',
  'g'   => 'gram',
  'kg'  => 'kilogram',
  'kgs' => 'kilogram',
  'l'   => 'liter',
  'lb'  => 'pound',
  'lbs' => 'pound',
  'ml'  => 'milliliter',
  'mls'  => 'milliliter',
  'oz'  => 'ounce',
  'ozs' => 'ounce',
  'pt'  => 'pint',
  'pts' => 'pint',
  't'   => 'teaspoon',
  'tsp' => 'teaspoon',
  'tsps'=> 'teaspoon',
  't'   => 'tablespoon',
  'tb'  => 'tablespoon',
  'tbs' => 'tablespoon',
  'tbl' => 'tablespoon',
  'tbls'=> 'tablespoon',
  'tbsp'=> 'tablespoon',
  'tbsps'=> 'tablespoon'
  } 

# FOR CONVERTING TO METRIC SYSTEM
# pinch = 1/8 teaspoon
# teaspoons
# tablespoons
# jigger 
# cup
# pint
# quart
# gallon


