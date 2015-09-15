class Fibonnaci
	def initialize
		@memory = {}
	end
	
	def fibs(n)
		arr = []
		for i in (1..n)
			arr << 1 if i == 1
			arr << 1 if i == 2
			arr << (arr[arr.length-2] + arr[arr.length-1]) if i >= 3
		end
		arr[arr.length-1]
	end

	def fibs_rec(n)
		return @memory[n] if @memory.has_key?(n)
		return 1 if n <= 2
		return @memory[n] ||= fibs_rec(n-2)+fibs_rec(n-1) if n > 2
	end
end

f = Fibonnaci.new
(1..100).to_a.each do |i|
	puts "fib #{i} = #{f.fibs_rec(i)}"
end

(1..10).to_a.each do |i|
	puts "fib #{i} = #{f.fibs(i)}"
end