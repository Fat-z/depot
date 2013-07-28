class AdminController < ApplicationController
  def index
  	@Line_items = LineItem.all
    @total_orders = Order.count
    @total_products_C = Product.count
    @total_lineitems = LineItem.count
    @total_order_number = Order.count
    @total_user_number = User.count
    @total_products_S = Product.where(publish: User.find_by_id(session[:user_id]).name).count

    @order_number = 0
    LineItem.all.each do |line_item|
    	if Product.find_by_id(line_item.product_id).publish == User.find_by_id(session[:user_id]).name
    		@order_number = @order_number + 1
    	end
    end
  end
end
