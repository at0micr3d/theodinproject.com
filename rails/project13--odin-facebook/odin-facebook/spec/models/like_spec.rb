require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "validations" do
  	it { is_expected.to validate_presence_of(:user_id) }
  	it { is_expected.to validate_presence_of(:post_id) }
  	it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe "associations" do
		it { is_expected.to belong_to(:user) }
		it { is_expected.to belong_to(:post) }
	end

	describe "methods" do
		
	end
end
