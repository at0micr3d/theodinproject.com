require 'yaml'

class Hangman
	def initialize
		@secret_word = load_secret_word	
		@guessed_letters = []
		@turns = 15
		@lost = false
		@won = false		
		puts "This is Hangman!\n\n"
	end

	def play
		until @won || @lost 
			puts "Guess a letter. (or 'save' your game)"
			guess = gets.chomp.downcase
			if guess == "save" 
				s = Storage.new
				s.save_game(self)
			else
				@turns -= 1
				@guessed_letters << guess[0]
				feedback = give_feedback
				@lost = true if @turns == 0
				@won = true if all_letters?(feedback)
			end
		end
		puts "\nCongratulations! You won!" if @won
		if @lost
			puts "\nUnfortunately, you ... hang." 
			puts "The correct answer was: #{@secret_word}"
		end
	end

	def give_feedback
		feedback = ""
		@secret_word.each_char do |c|
			char = "_"
			@guessed_letters.each do |gl|
				if c == gl
					char = gl
				end
			end
			feedback << char
		end
		puts "#{feedback}, Guesses: #{@guessed_letters.join(', ')}. Turns left: #{@turns}"
		return feedback
	end
	
	
	private

	def load_secret_word
		word = "s"
		until word.length > 5 && word.length < 12
			word = File.read("5desk.txt").split.sample
		end
		word.downcase
	end

	def all_letters?(feedback)
		feedback.scan(/_/).length == 0
	end

end

class Storage
	def initialize
		@save_path = "saves/save"
	end

	def load_game
		f = File.open(@save_path).read#lines.join()
		YAML::load(f)	
	end

	def save_game(game)
		save_yaml = YAML::dump(game)
		f = File.open(@save_path, 'w') do |f|
			f.write save_yaml
		end
		puts "Game saved!"
	end
end


puts "load previous game? y/n\n"
if gets.chomp == "y"
	h = Storage.new.load_game
	h.give_feedback
else
	h = Hangman.new
end
h.play



