require 'pry'

class Node
	attr_accessor :parent, :position

	def initialize(position = [0,0])
		@position = position
		@parent = []
	end

	def ==(another_node)
    @position[0] == another_node.position[0] && @position[1] == another_node.position[1] 
  end

  def empty?
  	false
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
		@queue = Queue.new
		@possible_moves = [[1,2], [-1,2], [-1,-2], [1,-2], [2,1], [-2,1], [-2,-1], [2,-1]]
	end
	
	#return the moves that the knight needs to take to get from pos1 to pos2
	def knight_moves(pos1, pos2)
		root = Node.new(pos1)
		breadth_first_search(root, pos2)
	end

	private
	
	def breadth_first_search(parent, to_find_pos)
		@possible_moves.each do |direction|
			new_position = new_pos(parent.position, direction)
			if @b.valid_pos?(new_position) && @b.board[new_position][:visited] == false
		 		n = Node.new(new_position)
		 		n.parent = parent
		 		if n.position == to_find_pos
		 			print_moves n
		 		end
		 		@queue.enq(n)
		 		@b.board[n.position][:visited] = true
	 		end		 		
		end
	 	breadth_first_search(@queue.deq, to_find_pos) if not @queue.empty?
	end

	def new_pos(pos, direction)
		new_pos = [0, 0]
		new_pos[0] = pos[0] + direction[0]
		new_pos[1] = pos[1] + direction[1]
		return new_pos
	end

	def print_moves(node)
		travel_list = list_parents(node).reverse
		puts "You made it in #{travel_list.length - 1} moves!  Here's your path:"
		travel_list.each { | k | puts k.to_s }		
	end

	def list_parents(node, list = [node.position])
    list_parents(node.parent, list << node.parent.position) unless node.parent.kind_of? Array
    list
  end
end


3.times do
	#creates a random from and to position
	puts "__________________________________________"
	knight = Knight.new.knight_moves([[*1..6].sample,[*1..6].sample], [[*1..6].sample,[*1..6].sample])
	puts "__________________________________________"
	puts ""
end



