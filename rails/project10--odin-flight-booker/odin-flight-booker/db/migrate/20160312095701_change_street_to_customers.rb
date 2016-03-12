class ChangeStreetToCustomers < ActiveRecord::Migration
  def change
  	change_column :customers, :street, :string
  end
end
