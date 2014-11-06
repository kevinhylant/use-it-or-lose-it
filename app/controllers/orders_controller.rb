class OrdersController < ApplicationController

  def new   #leftover_entry_page
    @order = Order.new
  end
  
  def create
    @order = Order.new
    leftovers_ary = (params[:order][:leftovers]).split(/\s*,\s*/)
    @order.create_recipes_and_ingredients(leftovers_ary)
    redirect_to order_path(@order)
  end

  def show

    @order = Order.find(params[:id])
  end

  # def index
  #   @lists = List.all
  #   @list = List.new
  # end


  

  # private
  #   def list_params
  #     params.require(:list).permit(:name, :items_attributes => [:description, :priority])
  #   end

end
