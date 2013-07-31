class AddUserNameToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :user_name, :string
  end
end
