class IngredientsController < ApplicationController

  def index
    @order = Order.find(params[:order_id])
    @ingredients = @order.ingredients
  end

end
