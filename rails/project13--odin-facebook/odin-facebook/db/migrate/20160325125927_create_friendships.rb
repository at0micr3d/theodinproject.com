class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :requester_id
      t.integer :requestee_id

      t.timestamps null: false
    end
    add_index :friendships, :requester_id
    add_index :friendships, :requestee_id
  end
end
