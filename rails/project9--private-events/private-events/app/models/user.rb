class User < ActiveRecord::Base
	has_many :owner_events, :foreign_key => "owner_id", :class_name => "Event"
end
