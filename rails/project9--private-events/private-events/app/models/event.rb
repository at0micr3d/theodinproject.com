class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User"
	has_many :invitations
	has_many :invitees, :through => :invitations, :source => :user
end
