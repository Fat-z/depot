class AddRepertoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :repertory, :integer, default: 1
  end
end
