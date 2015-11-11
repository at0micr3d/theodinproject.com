class AddColumsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :adress, :string
  	add_column :users, :phone_no, :integer
  end
end
