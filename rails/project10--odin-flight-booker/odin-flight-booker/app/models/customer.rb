class Customer < ActiveRecord::Base
	has_one :booking
end
