class CommentLineItem < ActiveRecord::Base
  attr_accessible :comment_content, :comment_id, :product_id
  validates :comment_content, presence: true
  belongs_to :comment
  belongs_to :product
end
