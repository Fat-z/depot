class AddCommentToVisions < ActiveRecord::Migration
  def change
    add_column :visions, :comment, :string
  end
end
