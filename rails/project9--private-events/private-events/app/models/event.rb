class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User"
	has_many :invitations
	has_many :invitees, :through => :invitations, :source => :user

	scope :future, -> { where("date > ?", Time.now) }
	scope :past, -> { where("date < ?", Time.now) }

end
