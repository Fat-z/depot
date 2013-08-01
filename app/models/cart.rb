class Cart < ActiveRecord::Base
  belongs_to  :user
  attr_accessible :user_id, :user_name
  
  validates :user_id, :user_name, presence: true
    
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
      #Product.find_by_id(product_id).temprepertory -= 1
      #Product.save
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def clear_up
    line_items.each do |line_item|
      @product = Product.find_by_id(line_item.product_id)
      @product.temprepertory += line_item.quantity 
      @product.save
    end 
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  
  def merge_carts(cart_merge)
    cart_merge.line_items.each do |item|
      current_item = line_items.find_by_product_id( item.product_id )
      
      if current_item
        current_item.quantity += item.quantity
        
      else
       current_item = line_items.build(product_id: item.product_id)
       current_item.quantity = item.quantity
      end
      current_item.save
    end  
  end
  
end
