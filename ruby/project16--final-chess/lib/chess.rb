require_relative 'pieces'
require 'pry'

class Board
  attr_accessor :position
  def initialize
    @position = Hash.new
    create_positions
  end
  
  def print_positions
    return  %Q{
          +---+---+---+---+---+---+---+---+
        8 | #{print_sqr(@position[[1,8]])} | #{print_sqr(@position[[2,8]])} | #{print_sqr(@position[[3,8]])} | #{print_sqr(@position[[4,8]])} | #{print_sqr(@position[[5,8]])} | #{print_sqr(@position[[6,8]])} | #{print_sqr(@position[[7,8]])} | #{print_sqr(@position[[8,8]])} |
          +---+---+---+---+---+---+---+---+
        7 | #{print_sqr(@position[[1,7]])} | #{print_sqr(@position[[2,7]])} | #{print_sqr(@position[[3,7]])} | #{print_sqr(@position[[4,7]])} | #{print_sqr(@position[[5,7]])} | #{print_sqr(@position[[6,7]])} | #{print_sqr(@position[[7,7]])} | #{print_sqr(@position[[8,7]])} |
          +---+---+---+---+---+---+---+---+
        6 | #{print_sqr(@position[[1,6]])} | #{print_sqr(@position[[2,6]])} | #{print_sqr(@position[[3,6]])} | #{print_sqr(@position[[4,6]])} | #{print_sqr(@position[[5,6]])} | #{print_sqr(@position[[6,6]])} | #{print_sqr(@position[[7,6]])} | #{print_sqr(@position[[8,6]])} |
          +---+---+---+---+---+---+---+---+
        5 | #{print_sqr(@position[[1,5]])} | #{print_sqr(@position[[2,5]])} | #{print_sqr(@position[[3,5]])} | #{print_sqr(@position[[4,5]])} | #{print_sqr(@position[[5,5]])} | #{print_sqr(@position[[6,5]])} | #{print_sqr(@position[[7,5]])} | #{print_sqr(@position[[8,5]])} |
          +---+---+---+---+---+---+---+---+
        4 | #{print_sqr(@position[[1,4]])} | #{print_sqr(@position[[2,4]])} | #{print_sqr(@position[[3,4]])} | #{print_sqr(@position[[4,4]])} | #{print_sqr(@position[[5,4]])} | #{print_sqr(@position[[6,4]])} | #{print_sqr(@position[[7,4]])} | #{print_sqr(@position[[8,4]])} |
          +---+---+---+---+---+---+---+---+
        3 | #{print_sqr(@position[[1,3]])} | #{print_sqr(@position[[2,3]])} | #{print_sqr(@position[[3,3]])} | #{print_sqr(@position[[4,3]])} | #{print_sqr(@position[[5,3]])} | #{print_sqr(@position[[6,3]])} | #{print_sqr(@position[[7,3]])} | #{print_sqr(@position[[8,3]])} |
          +---+---+---+---+---+---+---+---+
        2 | #{print_sqr(@position[[1,2]])} | #{print_sqr(@position[[2,2]])} | #{print_sqr(@position[[3,2]])} | #{print_sqr(@position[[4,2]])} | #{print_sqr(@position[[5,2]])} | #{print_sqr(@position[[6,2]])} | #{print_sqr(@position[[7,2]])} | #{print_sqr(@position[[8,2]])} |
          +---+---+---+---+---+---+---+---+
        1 | #{print_sqr(@position[[1,1]])} | #{print_sqr(@position[[2,1]])} | #{print_sqr(@position[[3,1]])} | #{print_sqr(@position[[4,1]])} | #{print_sqr(@position[[5,1]])} | #{print_sqr(@position[[6,1]])} | #{print_sqr(@position[[7,1]])} | #{print_sqr(@position[[8,1]])} |
          +---+---+---+---+---+---+---+---+
            a   b   c   d   e   f   g   h
    }
  end
  
  private
  
# prints the individual squares on the board. is able to handle both pieces and empty squares. returns a string.
  def print_sqr(position_value)
    if position_value != nil
      return position_value.unicode
    else
      return " "
    end
  end
  
  # Creates the chess board with all pieces. pieces are seperate classes. the board is a hash with 1x2 arrays as keys. function returns nothing but populates instance variable @position.
  def create_positions
    # create all 8x8 positions, where [1,1] is downleft and [8,8] is up right also [x,y] where x is horizontal and y is vertical.
    for i in 1..8
      for j in 1..8
        @position[[i,j]] = nil
      end
    end
    # fill all pieces:
    # add all pawns
    for i in 1..8
      @position[[i,2]] = Pawn.new(:w)
      @position[[i,7]] = Pawn.new(:b)
    end
    # add rooks
    @position[[1,8]] = Rook.new(:b)
    @position[[1,1]] = Rook.new(:w)
    @position[[8,8]] = Rook.new(:b)
    @position[[8,1]] = Rook.new(:w)
    # Add Knights
    @position[[2,8]] = Knight.new(:b)
    @position[[2,1]] = Knight.new(:w)
    @position[[7,8]] = Knight.new(:b)
    @position[[7,1]] = Knight.new(:w)
    # add bishops
    @position[[3,8]] = Bishop.new(:b)
    @position[[3,1]] = Bishop.new(:w)
    @position[[6,8]] = Bishop.new(:b)
    @position[[6,1]] = Bishop.new(:w)
    # add kings
    @position[[4,8]] = King.new(:b)
    @position[[4,1]] = King.new(:w)
    # add queens
    @position[[5,8]] = Queen.new(:b)
    @position[[5,1]] = Queen.new(:w)
  end
end

class Chess
  attr_reader :status
  
  def initialize
    @board = Board.new
    @status = :ongoing
    @prev_moves = []
    puts @board.print_positions
  end
  
  #prints winner and congratulations at end of the game
  def print_end_message
    #stub
  end
  
  #main method of the class. contains most of the game logic. moves pieces around the board.
  def make_move(arg)
    from = arg[0]
    to = arg[1]
    color = arg[2]
    move_executed = false

    if valid_from?(from, color) 
      case @board.position[from].type
      when :knight || :bishop || :queen
        if valid_to?(from, to, color)
          move_piece(from, to)
          move_executed = true
        end
      when :pawn
        # normal case where pawn moves 1 step forward
        if valid_to?(from, to, color)
          move_piece(from, to)
          move_executed = true
        end
      # first move for pawn where he can take 2 steps forward
      # ..
      # en-passant move for pawn where he moves 1 step forward and 1 to the side and takes another piece of the board
      # ..
      when :king || :rook
        # normal case where pawn moves 1 step forward
        if valid_to?(from, to, color)
          move_piece(from, to)
          move_executed = true
        end
        # castling move where castle replaces the king and the king moves 2 left or right
        # ..
      end
    end

    # make_move function prints board and returns true if the move was valid. gives error message and returns false if not.
    if move_executed == true
      puts @board.print_positions
      return true
    else
      puts "That move is not valid. Please try again."
      return false
    end
  end

  #returns all possible moves for a given player in the form of an array
  def possible_moves(color)
    #stub
  end

  private

  def move_piece(from,to)
    @board.position[to] = @board.position[from]
    @board.position[from] = nil
  end

  #returns true if the from location is valid. i.e. current player piece is on from location
  def valid_from?(from, color)
    if @board.position[from] != nil && @board.position[from].color == color
      return true
    else
      return false
    end
  end

  #returns true if the to location is valid. i.e. inside chess board, not on own piece and within standard piece possible moves ability. beware: not taking into account the special moves like en-passant, etc
  def valid_to?(from, to, color)
    if valid_from?(from, color)
      on_board = to[0] > 0 && to[0] < 9 && to[1] > 0 && to[1] < 9
      if @board.position[to] != nil #if position filled it should not be the same color
        to_not_same_color = @board.position[to].color != color
      else
        to_not_same_color = true
      end
      within_move_ability = @board.position[from].possible_moves.any? { |dir| from[0] + dir[0] == to[0] && from[1] + dir[1] == to[1] }
      if on_board && to_not_same_color && within_move_ability
        return true
      else
        return false
      end
    end
  end

end

class Game
  def initialize
    puts "This is the ancient game of chess. Many have gone before and many shall go after. But this is your turn!"
    puts ""
    @chess = Chess.new

    colors = choose_colors
    @players = [Human.new(colors[0].to_sym), Human.new(colors[1].to_sym)].cycle
  end
  
  def start
    while @chess.status == :ongoing
      # get a move from the next player and make it. repeat until its valid. (returns true)
      current_player = @players.next
      until @chess.make_move(current_player.get_move)
      end
    end
    @chess.print_end_message
  end

  private
  # let the player choose a color (and thus a side). other player gets the other color. (and side)
  def choose_colors
    puts "Player 1. Choose your color. Black or White. (type 'b' or 'w')"
    player1_color = ""
    until player1_color == "b" || player1_color == "w"
      player1_color = gets.chomp.downcase.to_s
      puts "That's not an option. Please try again" if player1_color.scan(/[bw]/).length != 1
    end
    player2_color = "b" if player1_color == "w"
    player2_color = "w" if player1_color == "b"
    puts "That makes player 2: #{player2_color}."
    return [player1_color, player2_color]
  end
end

class AI
  # stub
end

class Human
  def initialize(color)
    @color = color
  end
  # get a move from the player. returns an array in the form of [from_position, to_position, player_color]
  def get_move
    puts "Please make a move player #{@color.to_s}. (type the from location followed by the to location, divided by a space. example: 'a2 a3')"
    move = []
    until move.length == 2
      move = gets.chomp.downcase.to_s.scan(/\w+/)
      puts "That's not a valid option. Please try again" if move.length != 2
    end
    move = parse(move)
    return [move[0], move[1], @color.to_sym]
  end

  def parse(move)
    # replace all letters with the number that is used internally
    move.map! do |e|
      e.gsub(/a/, '1').gsub(/b/, '2').gsub(/c/, '3').gsub(/d/, '4').gsub(/e/, '5').gsub(/f/, '6').gsub(/g/, '7').gsub(/h/, '8')
    end

    # change the 2 digit string ("11") into an array of 1x2 of integers ([1, 1])
    move.map do |e|
      e.scan(/./).map { |str| str.to_i }
    end
    # 
  end
end
