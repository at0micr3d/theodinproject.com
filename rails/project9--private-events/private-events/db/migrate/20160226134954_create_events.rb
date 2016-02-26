class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :location
      t.date :time

      t.timestamps null: false
    end
  end
end
