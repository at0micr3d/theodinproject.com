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
				expect( arr.my_all? ).to be true
			end
		end
	end

	describe "#my_none?" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
		
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
	end

	describe "#my_count" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
		
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
	end

	describe "#my_map" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
		
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
	end

	describe "#my_inject" do
		before :each do
			@arr = [1,2,3]
			@hash = {:test => "yes", "no" => :test2, 2 => true}
		end	
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
		
		context "" do
			xit "" do
							
			end
			
			xit "" do
							
			end
		end
	end
		
end