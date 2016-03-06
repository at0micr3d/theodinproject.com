class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, :index => true
      t.integer :age
      t.integer :passport_nr
      t.integer :street
      t.string :city

      t.timestamps null: false
    end
  end
end
