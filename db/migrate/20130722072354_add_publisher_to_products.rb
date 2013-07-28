class AddPublisherToProducts < ActiveRecord::Migration
  def change
    add_column :products, :publish, :string
  end
end
