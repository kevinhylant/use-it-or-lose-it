class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def unit=(type)
    @type = type
    @type = 'tablespoon' if type = 'tb'
  end
  
end
