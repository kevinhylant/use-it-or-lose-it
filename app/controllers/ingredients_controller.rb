class IngredientsController < ApplicationController

  def index
    @order = Order.find(params[:order_id])
    @order.create_shopping_list
    @ingredients = @order.ingredients
  end

end
