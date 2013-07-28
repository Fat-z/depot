class SendingController < ApplicationController
  def index
  	@line_item = LineItem.find_by_id(params[:id])
  	@book_title = Product.find_by_id(@line_item.product_id).title
  	@repertory = Product.find_by_id(@line_item.product_id).repertory
  	@order_number = @line_item.quantity
     respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  def sendout
    @line_item = LineItem.find(params[:id])
    SendingNotifier.sended(@line_item).deliver
    @product = Product.find(@line_item.product_id)
    @quantity = @line_item.quantity
    @product.repertory = @product.decrease(@quantity)
    @product.save
    @line_item.destroy
    redirect_to orders_url, notice: "Email has been sent"
  end

  def stockout
    @line_item = LineItem.find(params[:id])
    SendingNotifier.stockouted(@line_item).deliver
    redirect_to orders_url, notice: "Email has been sent"

  end


end
