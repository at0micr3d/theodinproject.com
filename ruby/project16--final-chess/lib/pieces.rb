module Pieces
  
  # abstract class used for commonality between pieces by means of inheritance
  class Piece
    attr_reader :color, :type, :unicode, :possible_moves
    attr_accessor :nr_moves

    def initialize(color)
      @color = color
      @nr_moves = 0
    end
  end

  # king piece in chess
  class King < Piece
    def initialize(color)
      super(color)
      @type = :king
      case @color
      when :w
        @unicode = "\u2654"
      when :b
        @unicode = "\u265A"
      end
      @possible_moves = [[1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1], [1,0]]
    end
  end

  # pawn piece in chess
  class Pawn < Piece  
    attr_reader :attack_moves
    def initialize(color)
      super(color)
      @type = :pawn
      case @color
      when :w
        @unicode = "\u2659"
        @possible_moves = [[0,1]]
        @attack_moves = [[1,1], [-1,1]]
      when :b
        @unicode = "\u265F"
        @possible_moves = [[0,-1]]
        @attack_moves = [[1,-1], [-1,-1]]
      end
    end
  end

  # knight piece in chess
  class Knight < Piece
    def initialize(color)
      super(color)
      @type = :knight
      case @color
      when :w
        @unicode = "\u2658"
      when :b
        @unicode = "\u265E"
      end
      @possible_moves = [[1,2], [-1,2], [-1,-2], [1,-2], [2,1], [-2,1], [-2,-1], [2,-1]]
    end
  end

  # queen piece in chess
  class Queen < Piece
    def initialize(color)
      super(color)
      @type = :queen
      case @color
      when :w
        @unicode = "\u2655"
      when :b
        @unicode = "\u265B"
      end
      @possible_moves = [
        [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [-1,0], [-2,0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0], [-8,0], [0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], [0,8], [0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7], [0,-8], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [8,8], [-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7], [-8,-8], [-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7], [-8,8], [-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7], [-8,8]
      ]
    end
  end

  # rook piece in chess
  class Rook < Piece
    def initialize(color)
      super(color)
      @type = :rook
      case @color
      when :w
        @unicode = "\u2656"
      when :b
        @unicode = "\u265C"
      end
      @possible_moves = [[1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [-1,0], [-2,0], [-3,0], [-4,0], [-5,0], [-6,0], [-7,0], [-8,0], [0,1], [0,2], [0,3], [0,4], [0,5], [0,6], [0,7], [0,8], [0,-1], [0,-2], [0,-3], [0,-4], [0,-5], [0,-6], [0,-7], [0,-8]]
    end
  end

  # bishop piece in chess
  class Bishop < Piece
    def initialize(color)
      super(color)
      @type = :bishop
      case @color
      when :w
        @unicode = "\u2657"
      when :b
        @unicode = "\u265D"
      end
      @possible_moves = [[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [8,8], [-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7], [-8,-8], [-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7], [-8,8], [1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7], [8,-8]]
    end
  end
end