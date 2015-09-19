require 'spec_helper'

describe String do 
	before :each do
		@string = "working"
	end	

	describe "#encrypt_caesar" do
		
		it "works with shift of 2" do
			str = 
			expect( @string.encrypt_caesar(2) ).to be_eql "yqtmkpi"
		end

		it "wraps around z" do
			expect( @string.encrypt_caesar(27) ).to be_eql @string.encrypt_caesar(1)
		end

		it "retains capital letters" do
			@string = "CaPiTaL"
			expect( @string.encrypt_caesar(2) ).to be_eql "EcRkVcN"
		end

		it "retain spaces in string" do
			@string = "including spaces"
			expect( @string.encrypt_caesar(2).split(' ').length ).to be_eql 2
		end

		it "is able to handle new line characters" do
			@string = "including \nnewlines"
			expect( @string.encrypt_caesar(2).split("\n").length ).to be_eql 2
		end
	end
end