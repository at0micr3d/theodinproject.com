#Tic-tac-toe on the command line.
class Board
	attr_accessor :board, :winner, :board_full
	BOARD_SIZE = 3

	def initialize
		@board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) {"."}}
		@winner = false
		@board_full = false
	end

	def show_board()
		puts ""
		puts "  _1___2___3_"
		puts "1| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
		puts "2| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
		puts "3| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
		puts "  -----------"
		puts ""
	end

	def make_a_move(current_player)
		move = gets.chomp
		@x = move.split[0].to_i-1
		@y = move.split[1].to_i-1
		@current_player = current_player
		if move_possible?
			@board[@y][@x] = @current_player.get_mark
			if winning_move?
				@winner = true
				puts "Congratulations #{current_player.name}, you have won!!"
			end
			if no_winner? and !@winner
				@board_full = true #if board is full the game will end as well
				puts "Unfortunately, nobody won. Stale-mate!"
			end
		else
			puts "Invalid move. Try again."
			make_a_move(@current_player)
		end
	end

	private

	def move_possible?
		BOARD_SIZE >= @x && BOARD_SIZE >= @y && @board[@y][@x] == "."
	end

	def winning_move?
		win = []
		for x in 0..BOARD_SIZE-1
			for y in 0..BOARD_SIZE-1
				win << true if can_go_right?(x,y) && horizontal_row_same?(x,y) #evaluation stops if first expression returns false
				win << true if can_go_down?(x,y) && vertical_row_same?(x,y) #evaluation stops if first expression returns false
				win << true if can_go_down_right?(x,y) && diagonal_row_down_same?(x,y) #evaluation stops if first expression returns false
				win << true if can_go_up_right?(x,y) && diagonal_row_up_same?(x,y) #evaluation stops if first expression returns false
			end
		end
		return win.any? {|i| i == true} #if any evaluated to true return true
	end

	#if board is full the game ends in stale-mate.
	def no_winner?
		full = []
		for x in 0..BOARD_SIZE-1
			for y in 0..BOARD_SIZE-1
				full << "." if @board[y][x] == "."
			end
		end
		full.none? { |e| e == "." }
	end
	def can_go_right?(x,y)
		(BOARD_SIZE-1) >= x && (BOARD_SIZE-1) >= (x + 1) && (BOARD_SIZE-1) >= (x + 2)
	end
	def can_go_down?(x,y)
		(BOARD_SIZE-1) >= y && (BOARD_SIZE-1) >= (y + 1) && (BOARD_SIZE-1) >= (y + 2)
	end
	def can_go_up?(x,y)
		(BOARD_SIZE-1) == y
	end
	def can_go_down_right?(x,y)
		can_go_right?(x,y) && can_go_down?(x,y)
	end
	def can_go_up_right?(x,y)
		can_go_right?(x,y) && can_go_up?(x,y)
	end
	def horizontal_row_same?(x,y)
		board[y][x] == @current_player.get_mark && board[y][x+1] == @current_player.get_mark && board[y][x+2] == @current_player.get_mark 
	end
	def vertical_row_same?(x,y)
		board[y][x] == @current_player.get_mark && board[y+1][x] == @current_player.get_mark && board[y+2][x] == @current_player.get_mark 
	end
	def diagonal_row_down_same?(x,y)
		board[y][x] == @current_player.get_mark && board[y+1][x+1] == @current_player.get_mark && board[y+2][x+2] == @current_player.get_mark 
	end
	def diagonal_row_up_same?(x,y)
		board[y][x] == @current_player.get_mark && board[y-1][x+1] == @current_player.get_mark && board[y-2][x+2] == @current_player.get_mark 
	end
end

class Player
	attr_reader :name

	def initialize(name, mark)
		@name = name
		@mark = mark
	end

	def get_mark()
		@mark
	end
end