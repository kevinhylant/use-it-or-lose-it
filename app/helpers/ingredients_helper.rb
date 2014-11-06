module IngredientsHelper

  def plural?(ingredient)
    ingredient.quantity > 1
  end

  def remove_if_not_plural(arg)
    arg <= 1 ? "" : arg
  end

end
