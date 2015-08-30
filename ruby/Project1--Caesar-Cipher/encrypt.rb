class String
	def encrypt_caesar(shift)
		split('').map {|char| shift_char(char, shift)}.join
	end
	
	private
	def shift_char(char, shift)
		arr_down = ("a".."z").to_a
		arr_up = ("A".."Z").to_a
		case
		when arr_down.include?(char)
			 arr_down[(arr_down.index(char)+shift) % arr_down.length] #the % is necessary to wrap around from z to a.
		when arr_up.include?(char)
			 arr_up[(arr_up.index(char)+shift) % arr_up.length]
		else 
			char
		end
	end
end

p "What a string!".encrypt_caesar(5)
