require 'spec_helper'

describe Board do
  before :each do
    @board = Board.new
    
  end

  describe "#winning_move?" do

    it "should know there is a winner when winning condition is met" do
      @board.board[0][0] = "x" 
      @board.board[0][1] = "x"
      @board.board[0][2] = "x"
      expect{ @board.winning_move?.to be true }
    end

    it "should know there is no winner when nothing is filled" do
      expect{ @board.winning_move?.to be false }
    end

    it "should know there is no winner when there is no three in a row" do
      @board.board[0][0] = "x" 
      @board.board[0][1] = "x"
      @board.board[1][2] = "x"
      expect{ @board.winning_move?.to be false }
    end

    it "should know there is a winner in three in a row up to down" do
      @board.board[0][0] = "x" 
      @board.board[1][1] = "x"
      @board.board[2][2] = "x"
      expect{ @board.winning_move?.to be true }
    end

    it "should know bottom left to top right wins" do
      @board.board[2][0] = "x" 
      @board.board[1][1] = "x"
      @board.board[0][2] = "x"
      expect{ @board.winning_move?.to be true }
    end
  end
  
  describe "#no_winner?" do
    before :each do 
      @board.board.map! {|arr| arr.map! {|i| i = "x"} }
      endx

    it "should return true when the board is full" do
      expect{ @board.no_winner?.to be true}
    end

    it "should return false when move is still posible" do
      @board.board[1][1] = "."
      expect{ @board.no_winner?.to be false }
    end
  end

  describe "#show_board" do
    specify { expect { @board.show_board}.to output.to_stdout }
    specify { expect { @board.show_board}.to output(/1/).to_stdout }
  end
end

describe "Player" do
  describe "#get_mark" do
    it "gets back the players mark" do
      p = Player.new("frits","x")
      expect{ p.get_mark.to be("x") }
    end
  end
end
