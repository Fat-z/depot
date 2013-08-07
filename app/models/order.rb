class Order < ActiveRecord::Base
	belongs_to :user
	has_many :line_items, dependent: :destroy
	PAYMENT_TYPES = ["Check","Credict card", "Purchase order"]
	validates :name, :address, :email, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES
	attr_accessible :address, :email, :name, :pay_type
	attr_accessible :cart, :product, :user_id, :line_items

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
			
		end
	end

	def after_destroying_the_order
		line_items.each do |line_item|
			@product = line_item.product
			@product.temprepertory += line_item.quantity
			@product.save
		end
	end
end
