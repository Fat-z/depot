class AddNumberToVisions < ActiveRecord::Migration
  def change
    add_column :visions, :number, :integer, default: 1
  end
end
