require 'rails_helper'

RSpec.describe User, type: :model do
	it "has a valid factory" do
		expect(build(:user)).to be_valid
	end

	it "is invalid without a firstname" do
		expect(build(:user, firstname: nil)).to be_invalid
	end

	it "is invalid without a lastname" do
		expect(build(:user, lastname: nil)).to be_invalid
	end

	it "is invalid without an age" do
		expect(build(:user, age: nil)).to be_invalid
	end
	
	context "email adress" do
		it "is invalid without a value" do
			expect(build(:user, email: nil)).to be_invalid
		end

		it "is invalid when it is duplicate" do
			firstuser = create(:user, email: "test@test.nl")
			seconduser = build(:user, email: "test@test.nl")
			seconduser.valid?
			expect(seconduser.errors).to include(:email)
		end

		it "has a '@'" do
			expect(build(:user, email: "testtest.nl")).to be_invalid
		end
	end

	it "returns a contact's full name as a string" do
		expect(build(:user, firstname: 'Piet', lastname: 'Klaasen').name).to eql "Piet Klaasen"
	end

	context "by using friendship relationship" do

		it "is able to send a friendship request" do
			requesting_user = create(:user)
			requested_user = create(:user)

			# create(:friendship, requester_id: requesting_user, requestee_id: requested_user)
			friendship = requesting_user.requesting_friendships.create(requestee_id: requested_user)
			# friendship = Friendship.create(requester_id: requesting_user.id, requestee_id: requested_user.id)
			expect(friendship.requester_id).to eql requesting_user.id
		end

		it "is able to accept a friendship request"

		it "is able to get his requested friends"

		it "is able to get his requesting friends"

		it "is able to get all his friends"
	end

	context "by using post relationship" do

	end
end
