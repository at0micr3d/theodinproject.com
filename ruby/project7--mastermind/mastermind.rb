class Mastermind
	@@peg_colors_explained = {:r => "red", :o => "orange", :y => "yellow", :g => "green", :b => "blue", :p => "purple"}
	@@peg_colors = [:r, :o, :y, :g, :b, :p]
	@@score_peg_colors = [:black, :white]
	@@automatic_ai_feedback = false

	def initialize()
		@solution = [:r, :y, :b, :r] #the code
		@turn_input = [] #input of user. resets every turn.
		@feedback = [] #feedback on input. resets every turn.
		@turns = {} #storage of each turn information
		@win = false #victory condition met?
		@turn_nr = 1
		@answers = {} #used to keep track of all possible answers. only used in ai-mode.
	end
	
	def play
		puts "Do you:  "
		puts "1. want to play or"
		puts "2. let the computer play?"
		input = gets.chomp.scan(/[12]/)
		if input.any? { |e| e.to_s == "1" } 
			puts "You choose to play."
			play_player
		end
		if input.any? { |e| e.to_s == "2" } 
			puts "You choose to let the computer play."
			play_ai
		end
		unless input.any? { |e| e.to_s == "1" } || input.any? { |e| e.to_s == "2" }
			puts "You choose nothing"
		end
	end

	private
	
	def play_ai
		print_welcome_message_ai
		input = gets.chomp.scan(/[roygbp]/).map { |e| e.to_sym }
		if input.length == 4 #input is valid
			@solution = input
			@answers = generate_all_possibilities
			until @win || @turn_nr == 11
				@turn_input = get_ai_input!(@answers)
				puts "Computer thinks there are still: #{@answers.length} possibilities left." unless @answers.length == 1
				give_ai_feedback(@turn_input)
				check_win
				save_turn_and_reset
				print_game
			end
			if @win 
				puts "Computer won!" 
			else
				puts "Computer lost."
			end
		else
			puts "Invalid code."	
		end
	end

	def get_ai_input!(answers)
		unless @turns.empty?	
			#pretend for each answer that it is the code and check if it would have given the same output as the last feedback. If not then it can't be the code, so delete it..
			answers.each do |k,v| 
				answers.delete(k) unless @turns["turn #{@turn_nr-1}"][1].sort == evaluate_input(@turns["turn #{@turn_nr-1}"][0], v).sort
			end
			return answers.shift[1]
		else
			return answers.shift[1] #removes and returns the first array in the answers set
		end		
	end

	def give_ai_feedback(turn_input)
		if @@automatic_ai_feedback
			@feedback = evaluate_input(turn_input, @solution)
		else
			puts "\nComputer gives you answer: #{turn_input.to_s.gsub(/[\[\],:]/, "")}\n"
			puts "Your code is: #{@solution.to_s.gsub(/[\[\],:]/, "")}"
			puts "Please give the computer your evaluation. Use b for black and w for white. Example:"
			puts "bww"
			feedback = gets.chomp.scan(/[bw]/).map do |i| 
				case i.downcase
				when "b"
					i = :black
				when "w"
					i = :white
				end
			end
			@feedback = feedback
		end
	end

	def generate_all_possibilities
		possibilities = {}
		@@peg_colors.repeated_permutation(4).to_a.each_with_index do |pos, i|
			possibilities[i] = pos
		end
		possibilities
	end

	def play_player
		#@solution = rand_solution
		print_welcome_message_player
		until @win || @turn_nr == 11
			get_user_input
			@feedback = evaluate_input(@turn_input, @solution)
			check_win
			save_turn_and_reset
			print_game			
		end
		if @win
			puts "Congratulations! You win!"
		else
			puts "Unfortunately, you lost."
		end
	end

	def print_game
		puts "-----------------------"
		@turns.each do |k, v| 
			print "#{k}: "
			v[0].each {|i| print "#{i.to_s} "}
			print "  |  "  
			v[1].each {|i| print "#{i.to_s} "}
			print "\n"
		end		
		puts "-----------------------"
		puts "\n"
	end

	def check_win
		#set victory condition to true if all four are black 
		if @feedback.all? { |e| e == :black } && @feedback.length == 4
			@win = true 				
		end		
	end

	def save_turn_and_reset
		@turns["turn #{@turn_nr}"] = [@turn_input.clone, @feedback.clone]
		@turn_nr += 1
		#reset vars
		@turn_input = [] 
		@feedback = []
	end

	def rand_solution
		sol = []
		4.times { sol << @@peg_colors.sample }
		sol
	end

	def evaluate_input(input, solution)
		if input == []
			puts "invalid input" 
		else
			input = input.clone #necessary otherwise input into function will also change!
			solution = solution.clone
			feedback = []
			#check for correct color and correct position
			input.each_with_index do |peg, index|
				if solution[index] == peg
					feedback << :black
					input[index] = :blank_input_black #needs to be set to blank because they no longer need to taken in to account in subsequent evaluations.
					solution[index] = :blank_sol_black #needs to be set to blank because they no longer need to taken in to account in subsequent evaluations.
				end
			end
			#check for correct color of remaining colors
			input.each do |peg|
				solution.each_with_index do |s, i| 
					if peg == s 
						feedback << :white
						solution[i] = :blank_sol_white
						break
					end
				end
			end			
			#randomize feedback otherwise player might derive which position is okay
			return feedback.shuffle!
		end
	end

	def get_user_input
		puts "input please"
		input = gets.chomp.scan(/[a-z]/).map {|i| i.to_sym}
		if input.all? {|i| @@peg_colors.any? {|c| c == i}} && input.length == 4 #all collors are valid && 4 inputs
			@turn_input = input
		else
			@turn_input = []
		end
	end

	def print_welcome_message_player
		puts "Play Mastermind! For info on rules see:"
		puts "http://www.industrious.com/mastermind/gamerules.html"
		puts "Give your 4 color input by giving the first letter of the color."
		puts "Possible inputs are: " 
		@@peg_colors_explained.each { |k,v| puts "#{k.to_s}: #{v}" } 
		puts "\n"
		puts "example: rybr"
		puts "\n"
	end

	def print_welcome_message_ai
		puts "Let the computer play Mastermind! For info on rules see:"
		puts "http://www.industrious.com/mastermind/gamerules.html"
		puts "Give your secret code of 4 colors by giving the first letter of the color."
		puts "Possible inputs are: " 
		@@peg_colors_explained.each { |k,v| puts "#{k.to_s}: #{v}" } 
		puts "\n"
		puts "example: rybr"
		puts "\n"
	end
end

Mastermind.new.play