require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
  	it { is_expected.to validate_presence_of(:author_id) }
  	it { is_expected.to validate_presence_of(:post_id) }
  	it { is_expected.to validate_presence_of(:content) }
  end

  describe "associations" do
		it { is_expected.to belong_to(:author) }
		it { is_expected.to belong_to(:post) }
	end

	describe "methods" do

	end
end
