require 'pry'

class Location
	attr_accessor :pos, :visited
	
	def initialize(pos)
		@pos = pos
		@visited = false
	end
end

class Board
	attr_accessor :board

	def initialize
		@board = Hash.new 
		create_board
	end

	#don't go off board.
	def valid_pos?(pos)
		@board.has_key?(pos)
	end

	private

	#populate the board
	def create_board
		for i in 1..6
			for j in 1..6
				@board[[i,j]] = {:visited => false}
			end
		end
	end
end

class Knight

	def initialize
		@b = Board.new
		@possible_moves = [[1,2], [-1,2], [-1,-2], [1,-2], [2,1], [-2,1], [-2,-1], [2,-1]]
	end
	
	#return the moves that the knight needs to take to get from pos1 to pos2
	def knight_moves(pos1, pos2)
		stack = []
		stack.push pos1
		while !stack.empty?
			current_pos = stack.pop
			@possible_moves.each do |move| 
				new_position = new_pos(current_pos, move)
				if @b.valid_pos?(new_position) #new position is not outside the board?
					if new_position == pos2 #is the new position equal to the position that is looked for
						return print_moves(stack, pos1, pos2)
					end
					if @b.board[new_position][:visited] == false #check if the position is already visited 
						stack.push new_position 
						@b.board[new_position][:visited] = true
					end
				end
			end
		end
	end

	private

	def new_pos(pos, direction)
		new_pos = [0, 0]
		new_pos[0] = pos[0] + direction[0]
		new_pos[1] = pos[1] + direction[1]
		return new_pos
	end

	def print_moves(stack, pos1 ,pos2)
		puts "You made it in #{stack.length + 1} moves!  Here's your path:"
		puts pos1.to_s
		stack.each { | k | puts k.to_s }
		puts pos2.to_s
	end	
end

#knight = Knight.new.knight_moves([3,3], [4,5])
knight = Knight.new.knight_moves([3,3], [1,1])