require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
  	it { is_expected.to validate_presence_of(:content)}
  	it { is_expected.to validate_presence_of(:author_id)}
  end

  describe "associations" do
		it { is_expected.to belong_to(:author) }
		it { is_expected.to have_many(:likes) }
		it { is_expected.to have_many(:comments) }
	end

	describe "methods" do
		
	end
end
