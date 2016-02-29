class User < ActiveRecord::Base
	has_many :owner_events, :foreign_key => "owner_id", :class_name => "Event"
	has_many :invitations
	has_many :invitee_events, :through => :invitations, :source => :event
end
