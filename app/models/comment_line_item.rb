class CommentLineItem < ActiveRecord::Base
  attr_accessible :comment_content, :comment_id, :product_id, :comment_user_name
  validates :comment_content, presence: true
  
  belongs_to :comment
  belongs_to :product
end
