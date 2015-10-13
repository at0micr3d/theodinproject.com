require_relative 'pieces'
require 'pry'

# Board class, where all the visualization of chess and all the board pieces are situated in the position data structure.
class Board
  attr_accessor :position
  
  def initialize
    @position = Hash.new
    create_positions
  end

  # returns a string that represents the board as visualization of the game state to the user.
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
      @position[[i,2]] = Pieces::Pawn.new(:w)
      @position[[i,7]] = Pieces::Pawn.new(:b)
    end
    # add rooks
    @position[[1,8]] = Pieces::Rook.new(:b)
    @position[[1,1]] = Pieces::Rook.new(:w)
    @position[[8,8]] = Pieces::Rook.new(:b)
    @position[[8,1]] = Pieces::Rook.new(:w)
    # Add Knights
    @position[[2,8]] = Pieces::Knight.new(:b)
    @position[[2,1]] = Pieces::Knight.new(:w)
    @position[[7,8]] = Pieces::Knight.new(:b)
    @position[[7,1]] = Pieces::Knight.new(:w)
    # add bishops
    @position[[3,8]] = Pieces::Bishop.new(:b)
    @position[[3,1]] = Pieces::Bishop.new(:w)
    @position[[6,8]] = Pieces::Bishop.new(:b)
    @position[[6,1]] = Pieces::Bishop.new(:w)
    # add kings
    @position[[5,8]] = Pieces::King.new(:b)
    @position[[5,1]] = Pieces::King.new(:w)
    # add queens
    @position[[4,8]] = Pieces::Queen.new(:b)
    @position[[4,1]] = Pieces::Queen.new(:w)
  end
end

# Chess class, where all the game logic is implemented.
class Chess
  attr_reader :status, :board
  
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
  
  #main method of the class. this is where the magic happens. contains most of the game logic. moves pieces around the board.
  def make_move(arg)
    from = arg[0]
    to = arg[1]
    color = arg[2]
    move_executed = false

    if valid_from?(from, color)
      piece = @board.position[from]
      case piece.type
      when :knight, :bishop, :queen
        if valid_to?(from, to, color)
          move_piece(from, to)
          move_executed = true
        end
      when :pawn
        # normal case where pawn moves 1 step forward. pawn can not take another piece that is right in front of it.
        if valid_to?(from, to, color) && @board.position[to] == nil
          move_piece(from, to)
          piece.nr_moves =+ 1
          move_executed = true
        end
        # first move for pawn where he can take 2 steps forward
        if move_executed == false && piece.nr_moves == 0 && (from[1] + 2 == to[1] || from[1] - 2 == to[1])
          move_piece(from, to)
          piece.nr_moves =+ 1          
          move_executed = true
        end
        # en-passant move for pawn where he moves 1 step forward and 1 to the side and
        # takes another piece of the board ..
        if move_executed == false && en_passant?(from, to)
          move_piece(from, to)
          piece.nr_moves =+ 1
          @board.position[[to[0], from[1]]] = nil # set opposing piece position to nil
          move_executed = true
        end
        # promotes a pawn to a queeen when it reaches the opposing side (row 1 or 8)
        if promote?(to, color)
          move_piece(from, to)
          @board.position[to] = Pieces::Queen.new(color) # set piece to a queen
          move_executed = true
        end
      when :king
        # normal case where king or rook moves 1 step
        if valid_to?(from, to, color)
          move_piece(from, to)
          piece.nr_moves =+ 1
          move_executed = true
        end
        # castling move where rook replaces the king and the king moves 2 or 3 left or right
        if move_executed == false && castling?(from, to)
          move_piece(from, to)
          piece.nr_moves =+ 1

          # move the rook
          if to[0] > 4  # if its larger than 4 its on the right side of the board else left
            move_piece([8, from[1]], [to[0]-1, from[1]])
          else
            move_piece([1, from[1]], [to[0]+1, from[1]])
          end

          move_executed = true
        end
      when :rook
        if valid_to?(from, to, color)
          move_piece(from, to)
          piece.nr_moves =+ 1
          move_executed = true
        end        
      end
    end

    # make_move function prints board and returns true if the move was valid. gives error message and returns false if not.
    if move_executed == true
      puts @board.print_positions
      game_state?
      puts "Watch out: game is in check state.." if @status == :check
      return true
    else
      puts "That move is not valid. Please try again."
      return false
    end
  end

  #returns an array of all possible moves for a given player (color)
  def possible_moves(color)
    #stub
  end

  private

  # move a piece from location 'from' to location 'to'
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

  #returns true if the to location is valid. i.e. inside chess board, not on own piece, within standard piece possible moves ability and there are no pieces between from and to (with exception for knight). beware: not taking into account the special moves like en-passant, etc
  def valid_to?(from, to, color)
    if valid_from?(from, color)
      on_board = to[0] > 0 && to[0] < 9 && to[1] > 0 && to[1] < 9
      
      if @board.position[to] != nil #if position filled it should not be the same color
        to_not_same_color = @board.position[to].color != color
      else
        to_not_same_color = true
      end
      
      within_move_ability = @board.position[from].possible_moves.any? { |dir| from[0] + dir[0] == to[0] && from[1] + dir[1] == to[1] }
      
      no_pieces_between_from_and_to = false
      no_pieces_between_from_and_to = squares_between(from, to).all? { |pos| @board.position[pos] == nil }
      no_pieces_between_from_and_to = true if @board.position[from].type == :knight #exception for knight, who can jump over units.

      if on_board && to_not_same_color && within_move_ability && no_pieces_between_from_and_to
        return true
      else
        return false
      end
    end
  end

  # takes from and to position and returns the positions between those two positions in the form of an array.
  def squares_between(from, to)
    squares = []
    dx =  to[0] - from[0]
    dy = to[1] - from[1]
    x = 0
    y = 0
    for i in 1..[dx.abs, dy.abs].max 
      x = dx + i if dx < 0
      y = dy + i if dy < 0
      x = dx - i if dx > 0
      y = dy - i if dy > 0
      x = 0 if dx == 0
      y = 0 if dy == 0
      squares << [from[0] + x, from[1] + y]
    end
    squares = squares.delete_if { |pos| pos == from || pos == to }
    return squares
  end

  # returns true if the move is en-passant, otherwise false
  def en_passant?(from, to)
    if from[1] > to[1]
      # case pawn does en-passant from top to bottom
      piece = @board.position[from]
      enemy_piece_left = @board.position[[from[0] -1, from[1]]]
      enemy_piece_right = @board.position[[from[0] +1, from[1]]]

      piece_has_enemy_piece_left = (enemy_piece_left != nil && enemy_piece_left.color != piece.color)
      piece_has_enemy_piece_rigth = (enemy_piece_right != nil && enemy_piece_right.color != piece.color)
      if piece_has_enemy_piece_left
        piece_moves_1_in_x_axis = from[0] - 1 == to[0]
        piece_moves_1_in_y_axis = from[1] - 1 == to[1]
      end

      if piece_has_enemy_piece_rigth
        piece_moves_1_in_x_axis = from[0] + 1 == to[0]
        piece_moves_1_in_y_axis = from[1] - 1 == to[1]
      end

      return true if piece_moves_1_in_x_axis && piece_moves_1_in_y_axis && (piece_has_enemy_piece_left || piece_has_enemy_piece_rigth)
    else
      # case pawn does en-passant from bottom to top
      piece = @board.position[from]
      enemy_piece_left = @board.position[[from[0] -1, from[1]]]
      enemy_piece_right = @board.position[[from[0] +1, from[1]]]

      piece_has_enemy_piece_left = (enemy_piece_left != nil && enemy_piece_left.color != piece.color)
      piece_has_enemy_piece_rigth = (enemy_piece_right != nil && enemy_piece_right.color != piece.color)
      if piece_has_enemy_piece_left
        piece_moves_1_in_x_axis = from[0] - 1 == to[0]
        piece_moves_1_in_y_axis = from[1] + 1 == to[1]
      end

      if piece_has_enemy_piece_rigth
        piece_moves_1_in_x_axis = from[0] + 1 == to[0]
        piece_moves_1_in_y_axis = from[1] + 1 == to[1]
      end

      return true if piece_moves_1_in_x_axis && piece_moves_1_in_y_axis && (piece_has_enemy_piece_left || piece_has_enemy_piece_rigth)
    end
  end

  # checks if castling is possible. takes as arguments the kings from position and the to position the king will be after the castling. returns true if so, otherwise false
  def castling?(from, to)
    king = @board.position[from]
    # rules:
    # The king that makes the castling move has not yet moved in the game.
    king_not_moved_yet = king.nr_moves == 0

    # The rook that makes the castling move has not yet moved in the game. The King and rook must occupy the same rank (or row).
    if from[1] > 1
      # black is castling
      if to[0] > 5
        # right rook is used for castling
        rook_not_moved_yet = @board.position[[8,8]].nr_moves == 0
      else
        # left rook is used for castling
        rook_not_moved_yet = @board.position[[1,8]].nr_moves == 0
      end
    else
      # white is castling
      if to[0] > 5
        # right rook is used for castling
        rook_not_moved_yet = @board.position[[8,1]].nr_moves == 0
      else
        # left rook is used for castling
        rook_not_moved_yet = @board.position[[1,1]].nr_moves == 0
      end
    end

    # The king is not in check.
    # The king does not move over a square that is attacked by an enemy piece during the castling move, i.e., when castling, there may not be an enemy piece that can move (in case of pawns: by diagonal movement) to a square that is moved over by the king.
    #   The king does not move to a square that is attacked by an enemy piece during the castling move, i.e., you may not castle and end the move with the king in check.
    # Code explanation: check if any position in the range between the from and to location of the kings move can be reached (captured) by an enemy piece
    pos_in_range_is_capturable = false

    move_range_start = [from[0], to[0]].min
    move_range_end = move_range_start + (from[0] - to[0]).abs
    y_val = from[1]
    for i in move_range_start..move_range_end
      if capturable?([i, y_val], king.color)
        pos_in_range_is_capturable = true
      end
    end

    #   All squares between the rook and king before the castling move are empty.
    pos_in_range_is_empty = true
    move_range_start = [from[0], to[0]].min
    move_range_end = move_range_start + (from[0] - to[0]).abs
    y_val = from[1]
    for i in (move_range_start + 1)..move_range_end
      if @board.position[[i, y_val]] != nil
        pos_in_range_is_empty = false
      end
    end

    # if all conditions are met return true
    return king_not_moved_yet && rook_not_moved_yet && !pos_in_range_is_capturable && pos_in_range_is_empty
  end

  # returns true if the game is in a check state. i.e. if one of the two players can take the king of the other player in the next move
  def game_state?
    #find the kings positions
    pos_black_king = []
    pos_white_king = []
    @board.position.each do |cell, piece|
      if piece != nil
        pos_black_king = cell if piece.color == :b && piece.type == :king
        pos_white_king = cell if piece.color == :w && piece.type == :king
      end
    end 

    # are there any pieces on the board that can take the other colors king?
    if capturable?(pos_black_king, :b) || capturable?(pos_white_king, :w)
      @status = :check
    else
      @status = :ongoing
    end
  end

  # checks if the given position can be reached from an enemy piece. (not the color that is given) returns true if so, otherwise false
  def capturable?(position, color)
    piece_capturable = false
    @board.position.each do |cell, piece|
      if piece != nil && piece.color != color
          piece_capturable = piece.possible_moves.any? do |dir| 
            cell[0] + dir[0] == position[0] && cell[1] + dir[1] == position[1] 
          end
          break if piece_capturable
      end
    end 
    return piece_capturable
  end

  # checks if the first row of the enemy is reached
  def promote?(to, color)
    promote = false
    if to[1].to_i == 8 && color == :w
      promote = true
    end
    if to[1].to_i == 1 && color == :b
      promote = true
    end
    return promote
  end

end

# overarching class for the game. uses start function where input is gathered and given to the chess class.
class Game
  def initialize
    puts "This is the ancient game of chess. Many have gone before and many shall go after. But this is your turn!"
    puts ""
    @chess = Chess.new

    colors = choose_colors
    @players = [Human.new(colors[0].to_sym), Human.new(colors[1].to_sym)].cycle
  end

  # start the game and loop until game state is no longer ongoing
  def start
    while @chess.status == :ongoing || @chess.status == :check
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

# Human player who plays in the class 'game'. interaction vehicle for the user.
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

  # change the letter part of the user input to a letter and change string to to array
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
