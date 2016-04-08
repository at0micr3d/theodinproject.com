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
		let(:user) { create(:user) }
		let(:friend) { create(:user) }
		let(:not_a_friend) { create(:user) }
		let(:user_post) { create(:post, author_id: user.id) }
		let(:friend_post_1) { create(:post, author_id: friend.id) }
		let(:friend_post_2) { create(:post, author_id: friend.id) }
		let(:not_a_friend_post) { create(:post, author_id: not_a_friend.id) }

		context "#feed" do
			before :each do
				user.request_friendship(friend)
				friend.accept_request(user)
			end

			it "shows own posts" do
				expect(Post.feed(user)).to include(user_post)
			end

			it "shows friends posts" do
				expect(Post.feed(user)).to include(friend_post_1, friend_post_2)
			end

			it "shows only posts from friends" do
				expect(Post.feed(user)).not_to include(not_a_friend_post)
			end
		end
	end
end
