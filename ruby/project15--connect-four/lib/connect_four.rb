#abstract game class. Should be usable for different board games
class Game
  attr_accessor :players, :current_player, :game
  
  def initialize(game)
    @players = [Player.new("\u2460"), Player.new("\u2461")]
    @current_player = @players.cycle
    @game = game
  end

  def start_game
    until @game.winner? || @game.board_full?
      current_player = @current_player.next
      @game.make_move(current_player)
      puts @game.print_game_status
    end
    puts @game.print_winner(@players)
  end
end

#contains player information
class Player
  attr_accessor :symbol
  
  def initialize(symbol)
    @symbol = symbol
  end
end

#contains basic game rules and board
class ConnectFour
  attr_reader :board, :empty_sign

  def initialize
    @empty_sign = " " #"\u24C4"
    @board = create_board
    @winner = ""
  end
  
  def make_move(player)
    return "invalid input" if not player.is_a?(Player)
    return "full board" if board_full?
    
    puts "Which column do you want to drop your chip? Type 1,2,3,4,5 or 6."
    col = gets.chomp[0].to_i until [1,2,3,4,5,6].include?(col) && !full_column(col)
    drop_chip(col, player)
  end

  def print_winner(players)
    if self.winner?
      return "Player #{players.select { |p| p.symbol == @winner }[0].symbol} wins"
    else
      return "no winner"
    end
  end
 
  def winner?
    @winner = ""

    @board.each do |k,v|
      # horizontal check on x (of x,y)
      @winner = @board[[k[0],k[1]]] if @board[[k[0],k[1]]] == @board[[k[0]+1,k[1]]] && @board[[k[0],k[1]]] == @board[[k[0]+2,k[1]]] && @board[[k[0],k[1]]]== @board[[k[0]+3,k[1]]] && @board[[k[0],k[1]]] != @empty_sign 

      # vertical check on y
      @winner = @board[[k[0],k[1]]] if @board[[k[0],k[1]]] == @board[[k[0],k[1]+1]] && @board[[k[0],k[1]]] == @board[[k[0],k[1]+2]] && @board[[k[0],k[1]]]== @board[[k[0],k[1]+3]] && @board[[k[0],k[1]]] != @empty_sign 

      # diagonal check on x and y, bottom to top
      @winner = @board[[k[0],k[1]]] if @board[[k[0],k[1]]] == @board[[k[0]+1,k[1]-1]] && @board[[k[0],k[1]]] == @board[[k[0]+2,k[1]-2]] && @board[[k[0],k[1]]] == @board[[k[0]+3,k[1]-3]] && @board[[k[0],k[1]]] != @empty_sign

      # diagonal check on x and y, top to bottom 
      @winner = @board[[k[0],k[1]]] if @board[[k[0],k[1]]] == @board[[k[0]+1,k[1]+1]] && @board[[k[0],k[1]]] == @board[[k[0]+2,k[1]+2]] && @board[[k[0],k[1]]] == @board[[k[0]+3,k[1]+3]] && @board[[k[0],k[1]]] != @empty_sign
    end

    case @winner
    when ""
      return false
    else
      return true
    end
  end
  
  def board_full?
    not @board.any? { |k,v| v == @empty_sign }
  end

  def print_game_status
    <<-eos
   ===============================
   || #{@board[[1,1]]} | #{@board[[2,1]]} | #{@board[[3,1]]} | #{@board[[4,1]]} | #{@board[[5,1]]} | #{@board[[6,1]]} | #{@board[[7,1]]} ||
   -------------------------------
   || #{@board[[1,2]]} | #{@board[[2,2]]} | #{@board[[3,2]]} | #{@board[[4,2]]} | #{@board[[5,2]]} | #{@board[[6,2]]} | #{@board[[7,2]]} ||
   -------------------------------
   || #{@board[[1,3]]} | #{@board[[2,3]]} | #{@board[[3,3]]} | #{@board[[4,3]]} | #{@board[[5,3]]} | #{@board[[6,3]]} | #{@board[[7,3]]} ||
   -------------------------------
   || #{@board[[1,4]]} | #{@board[[2,4]]} | #{@board[[3,4]]} | #{@board[[4,4]]} | #{@board[[5,4]]} | #{@board[[6,4]]} | #{@board[[7,4]]} ||
   -------------------------------
   || #{@board[[1,5]]} | #{@board[[2,5]]} | #{@board[[3,5]]} | #{@board[[4,5]]} | #{@board[[5,5]]} | #{@board[[6,5]]} | #{@board[[7,5]]} ||
   -------------------------------
   || #{@board[[1,6]]} | #{@board[[2,6]]} | #{@board[[3,6]]} | #{@board[[4,6]]} | #{@board[[5,6]]} | #{@board[[6,6]]} | #{@board[[7,6]]} ||
   ===============================
      1   2   3   4   5   6   7   
		eos
  end

  private
  
  #creates board of x,y where x-axis 1 to 7, y-axis 1 to 6. Where 1,1 is topleft.
  def create_board
    b = Hash.new
    for i in 1..7
      for j in 1..6
        b[[i,j]] = @empty_sign
      end
    end
    return b
  end

  # check if the column is already full or not.
  def full_column(col)
    column = get_column(col)
    return !column.any? { |k,v| v == @empty_sign }
  end

  def drop_chip(col, player)
    for i in (6).downto(1)
      if @board[[col,i]] == @empty_sign
        @board[[col,i]] = player.symbol
        break
      end
    end
  end

  def get_column(col)
    return @board.select {|key, value| [col].include?(key[0].to_i) }
  end
end
