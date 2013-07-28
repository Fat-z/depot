class AddIdentityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identity, :string, default: 'customer'
  end
end
