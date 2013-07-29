class AddTemprepertoryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :temprepertory, :integer, default: 1
  end
end
