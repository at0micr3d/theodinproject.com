require 'rails_helper'

feature 'posts' do
	before :each do
    @user = create(:user, email: "test@test.com", password: "testtest")
    sign_in @user

    
	end

  scenario "user can create a post" do
    visit new_post_path
     
    expect {
    fill_in "post_content", with: Faker::Lorem.sentence
    click_button 'Create Post'
    }.to change(Post, :count).by(1)
  end

	scenario "index page works" do
  	visit posts_path

  	expect(page).to have_http_status(200)
  end

  given(:friend) { create(:user) }
  given(:not_a_friend) { create(:user) }
  given(:user_post) { create(:post, author_id: @user.id) }
  given(:friend_post_1) { create(:post, author_id: friend.id) }
  given(:friend_post_2) { create(:post, author_id: friend.id) }
  given(:not_a_friend_post) { create(:post, author_id: not_a_friend.id) }

  scenario "index page shows all users and friends posts" do
    visit posts_path
    expect(page).to have_content(@user.name)
    expect(page).to have_content(friend.name, count: 2)
    expect(page).not_to have_content(not_a_friend.name)

    expect(page).to have_content(friend_post_1.content)
    expect(page).to have_content(friend_post_2.content)
    expect(page).to have_content(user_post.content)
  end	
end
