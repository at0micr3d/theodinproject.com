require 'rails_helper'

feature 'likes' do
	before :each do
		@user = create(:user, email: "test@test.com", password: "testtest")
  	sign_in @user

    save_and_open_page
  

    visit new_post_path

    
    fill_in "post_content", with: Faker::Lorem.sentence
    click_button 'Create Post'
  end

	scenario "user can like a post" do
  	visit user_path(@user)

  	expect {
      click_button('Like')
    }.to change(Like, :count).by(1)
  end
end
