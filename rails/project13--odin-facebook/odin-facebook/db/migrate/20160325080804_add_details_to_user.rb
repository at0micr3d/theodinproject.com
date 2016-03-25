class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :Firstname, :string
    add_column :users, :Lastname, :string
    add_column :users, :age, :integer
  end
end
