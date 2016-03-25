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
			expect(build(:user, email: "test@test.nl")).to be_invalid
		end

		it "has a '@'" do
			expect(build(:user, email: "testtest.nl")).to be_invalid
		end
	end

	it "returns a contact's full name as a string" do
		expect(build(:user, firstname: 'Piet', lastname: 'Klaasen').name).to eql "Piet Klaasen"
	end
	

end
