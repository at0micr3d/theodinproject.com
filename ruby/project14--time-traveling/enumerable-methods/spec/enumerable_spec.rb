require 'spec_helper'

describe Enumerable do 
	
	describe "#my_each" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	

		it "returns an array" do
			expect( @arr.my_each {|i|  i } ).to be_eql(@arr.each {|i|  i } )
		end
		it { expect { |b| @arr.my_each(&b) }.to yield_successive_args(1, 2, 3) }

		it "does not change content of array" do
			expect( @arr.my_each {|i|  i = i + 1 } ).to be_eql(@arr)
		end

		it "returns a hash" do
			expect( @hash.my_each {|k,v| v } ).to be_a(Hash)
		end

		it "does not change a hash" do
			expect( @hash.my_each {|k,v| v = :tst } ).to be_eql(@hash)
		end
	end

	describe "#my_all?" do
		before :each do
			@arr = [1,2,3]
			@arr2 = [:oen, :two, "three"]
			@hsh = {"one" => :one, "two" => :two, :three => "threes"}
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	

		it "works with empty arrays" do
			arr = []
			expect( arr.my_all? {|i| i.is_a?(Integer) } ).to be true
		end
	
		it "returns false when 1 element does not comply" do
			expect( @arr2.my_all? {|k| k.is_a?(Symbol) } ).to be false
		end

		it "returns true when all elements comply with block" do
			expect( @arr.my_all? {|i| i.is_a?(Integer) } ).to be true
		end

		context "when no block is given" do
			it "returns false when array contains a nil" do
				arr = [nil, 1, 2, "three"]
				expect( arr.my_all? ).to be false
			end

			it "returns false when array contains a false" do
				arr = [false, 1, 2, "three"]
				expect( arr.my_all? ).to be false
			end
			
			it "returns true when array has no nil or false" do
				expect( @arr.my_all? ).to be true
			end
		end
	end

	describe "#my_none?" do
		before :each do
			@arr = [1,2,3]
		end	
		context "when a block is given" do
			it "works with empty arrays" do
			arr = []
			expect( arr.my_none? {|i| i.is_a?(Integer) } ).to be true
			end
			
			it "returns false when one or more elements in array satisfy block" do
				expect( @arr.my_none? {|i| i.is_a?(Integer) } ).to be false
			end
		end
		
		context "when no block is given" do
			it "returns false when array contains a nil" do
				arr = [nil, 1, 2, "three"]
				expect( arr.my_none? ).to be false
			end

			it "returns false when array contains a false" do
				arr = [false, 1, 2, "three"]
				expect( arr.my_none? ).to be false
			end
		end
	end

	describe "#my_count" do
		before :each do
			@arr = [1,2,3,4]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
		
		context "when an option is given " do
			it "counts the number of elements that are the same as the option" do
				expect( @arr.my_count(2) ).to be(1)	
			end
			
			it "returns 0 when no elements are matched" do
				expect( @arr.my_count(9) ).to be 0
			end
		end
		
		context "when a block is given but not an option" do
			it "returns the number of times the block is true" do
				expect( @arr.my_count {|i| i%2 == 0}).to be(2)
			end
		end
		
		it "returns the length of the array if when not option and no block is given" do
			expect( @arr.my_count).to be(4)			
		end
	end

	describe "#my_map" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	

		context "with a block" do
			it "does not change the original array" do
				r = @arr.clone
				@arr.map {|i| i + 1}
				expect( @arr ).to be_eql(r)
			end
			
			it "returns an array with the changes of the block" do
				expect( @arr.map {|i| i%2 }[1] ).to be 0
			end
		end
		
		context "without a block" do
			it "returns an error" do
				expect{ @arr.my_map.to raise_error(LocalJumpError) }
			end			
		end
	end

	describe "#my_inject" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
	
		it "returns the sum of an array" do
			expect{ @arr.my_inject {|sum, i| sum + i}.to be(6) }
		end
		
		it "uses the option as initial sum if given" do
			expect{ @arr.my_inject(2) {|sum, i| sum + i}.to be(8) }
		end
	end
		
end