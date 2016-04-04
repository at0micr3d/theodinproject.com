require 'rails_helper'

feature 'posts' do
	scenario "works after user login" do
		user = build(:user, email: "test@test.com", password: "testtest")
  	sign_in user

  	visit posts_path
  	expect(page).to have_http_status(200)
  end
end
