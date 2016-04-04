require 'rails_helper'

RSpec.describe User, type: :model do
	it "has a valid factory" do
		expect(build(:user)).to be_valid
	end

	describe "validations" do
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

		it "is default not an admin" do
			expect(create(:user).admin?).to eq(false)
		end
	end

	describe "associations" do
		it { is_expected.to have_many(:requesting_friendships).dependent(:destroy) }
		it { is_expected.to have_many(:requested_friendships).dependent(:destroy) }
		it { is_expected.to have_many(:requesting_friends) }
		it { is_expected.to have_many(:requested_friends) }
		it { is_expected.to have_many(:authored_posts) }
		it { is_expected.to have_many(:likes) }
		it { is_expected.to have_many(:liked_posts) }
	end

	describe "methods" do

		context "by using friendship relationship" do

			before :each do
				@requesting_user = create(:user)
				@requested_user = create(:user)
				@requesting_user.request_friendship(@requested_user)
			end

			it "is able to send a friendship request" do
				@requesting_user.request_friendship(@requested_user)
				expect(@requesting_user.requested_friendships.first.requestee_id).to eql @requested_user.id
			end

			it "is able to accept a friendship request" do
				@requested_user.accept_request(@requesting_user)
				expect(@requested_user.requesting_friendships.first.accepted).to eql true
			end

			it "is able to get his requested friends if they were accepted" do
				@requested_user.accept_request(@requesting_user)
				expect(@requesting_user.friends_who_have_accepted.take.id).to eql @requested_user.id
			end

			it "is not able to get his requested friends if they have not accepted" do
				expect(@requesting_user.friends_who_have_accepted.count).to eql 0
			end

			it "is able to get his requesting friends that he has accepted" do
				@requested_user.accept_request(@requesting_user)
				expect(@requested_user.friends_who_are_accepted.take.id).to eql @requesting_user.id
			end

			it "is not able to get his requesting friends that he has not accepted" do
				expect(@requested_user.friends_who_are_accepted.count).to eql 0
			end

			it "is able to get all his friends (either requested or requesting)" do
				user = create(:user)

				requesting_users = [ create(:user) , create(:user), create(:user), create(:user), create(:user) ]
				requesting_users.each do |u| 
					u.request_friendship(user) 
					user.accept_request(u)
				end

				to_request_users = [ create(:user) , create(:user) ]
				to_request_users.each do |u| 
					user.request_friendship(u)
					u.accept_request(user)
				end

				expect(user.friends.count).to eql 7
			end

		end

		describe "#friends_with?" do
			let(:user) { create(:user) }
			let(:not_a_friend) { create(:user) }
			let(:a_friend) { create(:user) }
			let(:requested_friend) { create(:user) }

			before(:each) do
        user.request_friendship(requested_friend)
        user.request_friendship(a_friend)
        a_friend.accept_request(user)
      end
			
			it "returns false when somebody is not a friend" do
				expect(user.friends_with?(not_a_friend)).to eq false
      end

      it "returns false when somebody is a requested friend but hasn't accepted yet" do
      	expect(user.friends_with?(requested_friend)).to eq false
      end

      it "returns true when somebody is a friend" do
      	expect(user.friends_with?(a_friend)).to eq true
      end
		end

		describe "#friend_request_pending?" do
			let(:user) { create(:user) }
			let(:requested) { create(:user) }
			let(:pending) { create(:user) }
			let(:no_relationship) { create(:user) }

			before(:each) do
        user.request_friendship(requested)
        pending.request_friendship(user)
      end
			
			it "returns false when no request is pending" do
				expect(user.friend_request_pending?(no_relationship)).to eq false
      end

      it "returns true when user has requested a friendship" do
      	expect(user.friend_request_pending?(requested)).to eq true
      end

      it "returns false when other user has requested a friendship" do
      	expect(user.friend_request_pending?(pending)).to eq false
      end
		end 

		describe "#friend_invite_pending?" do
			let(:user) { create(:user) }
			let(:requested) { create(:user) }
			let(:pending) { create(:user) }
			let(:no_relationship) { create(:user) }

			before(:each) do
        user.request_friendship(requested)
        pending.request_friendship(user)
      end
			
			it "returns false when no request is pending" do
				expect(user.friend_invite_pending?(no_relationship)).to eq false
      end

      it "returns false when user has requested a friendship" do
      	expect(user.friend_invite_pending?(requested)).to eq false
      end

      it "returns true when other user has requested a friendship" do
      	expect(user.friend_invite_pending?(pending)).to eq true
      end
		end

		describe "#has_liked?" do
			let(:user) { create(:user) }
			let(:like_post) { create(:post) }
			let(:not_like_post) { create(:post) }

			before :each do
				create(:like, :user_id => user.id, :post_id => like_post.id)
			end

			it "returns false if a post is not liked by user" do
				expect(user.has_liked?(not_like_post)).to eq false
			end

			it "returns true if a post is liked by user" do
				expect(user.has_liked?(like_post)).to eq true
			end
		end
	end

	

end
