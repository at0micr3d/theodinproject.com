class DropTableFriendships < ActiveRecord::Migration
  def up
  	drop_table :friendships
  end

  def down
  	create_table :friendships do |t|
      t.integer  :requester_id
      t.integer  :requestee_id      
    end
  end
end
