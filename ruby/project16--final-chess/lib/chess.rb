require './pieces.rb'

class Board
  attr_reader :position
  def initialize
    @position = Hash.new
    create_position
  end

  def create_position
    # create all 8x8 positions, where [1,1] is downleft and [8,8] is up right also [x,y] where x is horizontal and y is vertical.
    for i in 1..8
      for j in 1..8
	@position[[i,j]] = nil
      end
    end
    # all pawns
    for i in 1..8
      @positions[i,2] = Pawn.new(:w)
      @positions[i,7] = Pawn.new(:b)
    end
    
  end
end

class Chess
  
end

class Game
  
end

class AI
end

class Human
end
