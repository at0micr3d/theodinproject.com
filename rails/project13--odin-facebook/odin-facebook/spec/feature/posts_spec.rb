require 'rails_helper'

feature 'posts' do
	before :each do
		user = create(:user, email: "test@test.com", password: "testtest")
  	sign_in user
	end

	scenario "index page works" do
  	visit posts_path

  	expect(page).to have_http_status(200)
  end

	scenario "user can create a post" do
  	visit new_post_path
  	 
  	expect {
  	fill_in "post_content", with: Faker::Lorem.sentence
  	click_button 'Create Post'
    }.to change(Post, :count).by(1)
  end
end
