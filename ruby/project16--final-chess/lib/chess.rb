require 'pieces'

class Board
  attr_reader :position
  def initialize
    @position = Hash.new
    create_positions
  end
  
  def print_positions
    begin                    
puts         "+---+---+---+---+---+---+---+---+"
puts  "8 | #{@position[[1,8]].to_s} | #{@position[[2,8]].unicode} | #{@position[[3,8]].unicode} | #{@position[[4,8]].unicode} | #{@position[[5,8]].unicode} | #{@position[[6,8]].unicode} | #{@position[[7,8]].unicode} | #{@position[[8,8]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "7 | #{@position[[1,7]].unicode} | #{@position[[2,7]].unicode} | #{@position[[3,7]].unicode} | #{@position[[4,7]].unicode} | #{@position[[5,7]].unicode} | #{@position[[6,7]].unicode} | #{@position[[7,7]].unicode} | #{@position[[8,7]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "6 | #{@position[[1,6]].to_s} | #{@position[[2,6]].to_s} | #{@position[[3,6]].to_s} | #{@position[[4,6]].to_s} | #{@position[[5,6]].to_s} | #{@position[[6,6]].to_s} | #{@position[[7,6]].to_s} | #{@position[[8,6]].to_s} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "5 | #{@position[[1,5]].unicode} | #{@position[[2,5]].unicode} | #{@position[[3,5]].unicode} | #{@position[[4,5]].unicode} | #{@position[[5,5]].unicode} | #{@position[[6,5]].unicode} | #{@position[[7,5]].unicode} | #{@position[[8,5]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "4 | #{@position[[1,4]].unicode} | #{@position[[2,4]].unicode} | #{@position[[3,4]].unicode} | #{@position[[4,4]].unicode} | #{@position[[5,4]].unicode} | #{@position[[6,4]].unicode} | #{@position[[7,4]].unicode} | #{@position[[8,4]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "3 | #{@position[[1,3]].unicode} | #{@position[[2,3]].unicode} | #{@position[[3,3]].unicode} | #{@position[[4,3]].unicode} | #{@position[[5,3]].unicode} | #{@position[[6,3]].unicode} | #{@position[[7,3]].unicode} | #{@position[[8,3]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "2 | #{@position[[1,2]].unicode} | #{@position[[2,2]].unicode} | #{@position[[3,2]].unicode} | #{@position[[4,2]].unicode} | #{@position[[5,2]].unicode} | #{@position[[6,2]].unicode} | #{@position[[7,2]].unicode} | #{@position[[8,2]].unicode} |"
puts         "+---+---+---+---+---+---+---+---+"
puts  "1 | #{@position[[1,1]].unicode} | #{@position[[2,1]].unicode} | #{@position[[3,1]].unicode} | #{@position[[4,1]].unicode} | #{@position[[5,1]].unicode} | #{@position[[6,1]].unicode} | #{@position[[7,1]].unicode} | #{@position[[8,1]].unicode} |"
puts         " +---+---+---+---+---+---+---+---+"
puts           "1   2   3   4   5   6   7   8"
    rescue
      # prints a blank space on positions without a chess piece
      print " "
    end
  end
  
  private
  
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
  def initialize
    @board = Board.new
    
    @board.print_positions
  end
end

class Game
  def initialize
    @chess = Chess.new
    puts "This is the ancient game of chess. Many have gone before and many shall go after. But this is your turn!"
    colors = choose_colors
    @players = [Human.new(colors[0].to_sym), Human.new(colors[1].to_sym)]
  end
  
  def start
    while @chess.status == :ongoing
      # get a move from the next player and make it. repeat until its valid. (returns true)
      current_player = @players.cycle.next
      until true
        @chess.make_move(current_player.get_move)
      end
    end
    @chess.print_end_message
  end

  private
  # let the player choose a color (and thus a side). other player gets the other color (and side)
  def choose_colors
    puts "Player 1. Choose your color. Black or White. (type 'b' or 'w')"
    player1_color = ""
    until player1_color == ("b" || "w")
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
    puts "Please make a move player #{@color.to_s}. (type the from location followed by the to location, divided by a space)"
    move = []
    until move.length == 2
      move = gets.chomp.downcase.to_s.scan(/ /)
      puts "That's not a valid option. Please try again" if move.length != 2
    end
    return [move, @color.to_sym].flatten
  end
end
