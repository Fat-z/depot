class CreateCommentLineItems < ActiveRecord::Migration
  def change
    create_table :comment_line_items do |t|
      t.integer :product_id
      t.integer :comment_id
      t.text :comment_content
   
      t.timestamps
    end
  end
end
