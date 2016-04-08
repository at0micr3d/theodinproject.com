require 'rails_helper'

feature 'user management' do
	scenario "user signup" do
		user = build(:user)
		visit new_user_registration_path

	  expect{
	  	fill_in 'user_email', with: user.email
	  	fill_in 'user_firstname', with: user.firstname
	  	fill_in 'user_lastname', with: user.lastname
	  	fill_in 'user_age', with: user.age
	  	fill_in 'user_password', with: user.password
	  	fill_in 'user_password_confirmation', with: user.password
	  	click_button 'Sign up'
  	}.to change(User, :count).by(1)
	end
	
end