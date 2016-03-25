class RenameAttributesOfUser < ActiveRecord::Migration
  def change
  	rename_column :users, :Firstname, :firstname
  	rename_column :users, :Lastname, :lastname
  end
end
