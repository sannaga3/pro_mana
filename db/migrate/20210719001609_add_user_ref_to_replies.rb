class AddUserRefToReplies < ActiveRecord::Migration[5.2]
  def change
    remove_column :replies, :replier_id, :integer
    add_reference :replies, :user, foreign_key: true
  end
end
