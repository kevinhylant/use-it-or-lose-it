class OrdersController < ApplicationController


  def new   #leftover_entry_page
    @order = Order.new
    @order.recipes.build
  end
  
  def create
    
    @order = Order.new(params[:leftovers[])

    if @list.save
      redirect_to @list
      # redirect_to list_path(@list)
    else
      render :new
    end
  end

  # def show
  #   @list = List.find(params[:id])
  # end

  # def index
  #   @lists = List.all
  #   @list = List.new
  # end


  

  # private
  #   def list_params
  #     params.require(:list).permit(:name, :items_attributes => [:description, :priority])
  #   end

end
