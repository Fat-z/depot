class User < ActiveRecord::Base
  IDENTITY_TYPES = ["customer", "seller"]
  attr_accessible :name, :password_digest, :password, :password_confirmation, :identity
  validates :identity, inclusion: IDENTITY_TYPES
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