require "time"
class Timer
	def initialize()
		@seconds = 0
	end
	def seconds
		@seconds
	end
	def seconds=(seconds)
		@seconds = seconds
	end

	def time_string
		t = Time.at(@seconds)-(60*60)
		t.strftime("%H:%M:%S")
	end
end
