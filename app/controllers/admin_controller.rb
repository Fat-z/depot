class AdminController < ApplicationController
  def index
    @total_orders = Order.count
    @total_products_C = Product.count
    @total_products_S = Product.where(publish: User.find_by_id(session[:user_id]).name).count
  end
end
