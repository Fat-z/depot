class AddCommentUserNameToCommentLineItems < ActiveRecord::Migration
  def change
    add_column :comment_line_items, :comment_user_name, :string
  end
end
