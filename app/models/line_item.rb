class LineItem < ActiveRecord::Base
  belongs_to :product 
  belongs_to :order
  belongs_to :cart 
  attr_accessible :cart_id, :product_id, :quantity
  attr_accessible :product, :order

  def total_price
  	product.price * quantity
  end

  def count_Seller_orders
  	order_number = 0
  	LineItem.all.each do |line_item|
    	if Product.find_by_id(line_item.product_id).publish == User.find_by_id(session[:user_id]).name
    		order_number = order_number + 1
    	end
    end
    order_number
  end

  def count_user_orders
  	
  end

  def clear_the_item
    product.temprepertory += quantity
    product.save
  end

  def pre_repertory
    quantity + product.temprepertory
  end
  

end
