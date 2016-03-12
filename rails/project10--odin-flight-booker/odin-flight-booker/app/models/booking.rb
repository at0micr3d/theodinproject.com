class Booking < ActiveRecord::Base
	has_many :customers
	accepts_nested_attributes_for :customers
	has_one :flight

	validates_associated :customers
end
