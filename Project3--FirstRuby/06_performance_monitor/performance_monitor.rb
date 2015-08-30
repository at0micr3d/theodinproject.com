require "time"
def measure(n = 1)
	avg = []
	n.times do
		t = Time.now
		yield
		 avg.push(Time.now - t)
	end
	return 	avg.inject{ |sum, el| sum + el }.to_f / avg.size
end