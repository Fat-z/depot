class AddEmailToVisions < ActiveRecord::Migration
  def change
    add_column :visions, :email, :string
  end
end
