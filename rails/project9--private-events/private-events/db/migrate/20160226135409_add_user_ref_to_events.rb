class AddUserRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :owner, index: true, foreign_key: true
  end
end
