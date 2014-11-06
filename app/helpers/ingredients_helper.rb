module IngredientsHelper

  def plural?(ingredient)
    ingredient.quantity > 1
  end

end
