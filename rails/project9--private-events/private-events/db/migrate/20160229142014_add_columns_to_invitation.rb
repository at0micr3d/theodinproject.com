class AddColumnsToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :user_id, :integer
    add_column :invitations, :event_id, :integer
  end
end
