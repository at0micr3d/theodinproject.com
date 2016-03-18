class Booking < ActiveRecord::Base
	has_many :customers
	accepts_nested_attributes_for :customers
	belongs_to :flight

	validates_associated :customers
end
