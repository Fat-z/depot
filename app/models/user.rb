class User < ActiveRecord::Base
  has_many  :carts, dependent:  :destroy
  has_many  :orders, dependent: :destroy
  
  IDENTITY_TYPES = ["customer", "seller"]
  ALL_IDENTITY_TYPES = ["customer", "seller", "administrator"]
  attr_accessible :name, :password_digest, :password, :password_confirmation, :identity
  
  validates :identity, inclusion: ALL_IDENTITY_TYPES
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  after_destroy :ensure_an_admin_remains
  
  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end
