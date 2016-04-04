require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
  	it { is_expected.to validate_presence_of(:content)}
  	it { is_expected.to validate_presence_of(:author_id)}
  end

  describe "associations" do
		it { is_expected.to belong_to(:author) }
	end

	describe "methods" do
		
	end
end
