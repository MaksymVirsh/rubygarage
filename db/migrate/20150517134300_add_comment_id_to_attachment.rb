class AddCommentIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :comment_id, :integer
    add_index :attachments, :comment_id
  end
end
