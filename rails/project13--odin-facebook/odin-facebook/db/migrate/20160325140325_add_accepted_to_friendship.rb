class AddAcceptedToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :accepted, :boolean
    add_index :friendships, :accepted
  end
end
