class User < ActiveRecord::Base
	has_many :event_owners, :class_name => "Event", :foreign_key => "owner_id"
end
