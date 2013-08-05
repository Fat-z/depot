class CreateVisions < ActiveRecord::Migration
  def change
    create_table :visions do |t|
      t.string :title
      t.integer :publisher
      t.integer :taker

      t.timestamps
    end
  end
end
