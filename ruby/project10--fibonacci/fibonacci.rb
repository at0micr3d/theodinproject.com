class Fibonnaci
	def initialize
		@memory = {}
	end
	
	def fibs(n)
		return @memory[n] if @memory.has_key?(n)
		case 
		when n <= 2
			return 1
		when n > 2
			result = fibs(n-2)+fibs(n-1)
		end
		@memory[n] ||= result
		return result
	end
end

f = Fibonnaci.new
(1..100).to_a.each do |i|
	puts "fib #{i} = #{f.fibs(i)}"
end