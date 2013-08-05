class Vision < ActiveRecord::Base
  attr_accessible :publisher, :taker, :title, :number, :comment, :email
end
