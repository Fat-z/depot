class Vision < ActiveRecord::Base
  attr_accessible :publisher, :taker, :title, :number, :comment, :email
  validates :title, :comment, :number, :email, presence: true
  validates :number, numericality: {greater_than_or_equal_to: 1}
end
