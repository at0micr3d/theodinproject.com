class Piece
  attr_reader :color, :type, :unicode, :possible_moves
  def initialize(color)
    @color = color
  end
end

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

class Pawn < Piece
  def initialize(color)
    super(color)
    @type = :pawn
    case @color
    when :w
      @unicode = "\u2659"
    when :b
      @unicode = "\u265F"
    end
    @possible_moves = [[0,1],[0,-1]]
    @nr_moves = 0
  end
end

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
