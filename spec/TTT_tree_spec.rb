require 'rspec'
require 'TTT_tree'

RSpec.describe "TTT_tree" do
  describe "3x3 board" do
    let(:board) { Board.new }
    it "builds a list of children" do
      tree = TTT_Tree.new(board, "X")

      result = tree.children

      expect(result.length).to eq(9)
    end

    it "returns the immediate winning_move for player X" do
      board[0], board[1] = "O", "O"
      board[3], board[4] = "X", "X"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move

      expect(result).to eq("5")
    end

    it "returns the immediate winning_move for player O" do
      board[0]                     = "X"
                board[4]           =     "X"
                board[7], board[8] =     "O", "O"
      tree = TTT_Tree.new(board, "O")

      result = tree.best_move

      expect(result).to eq("6")
    end

    it "returns a winning move several moves away" do
                board[1]           =      "O"
      board[3], board[4], board[5] = "O", "X", "X"
                board[7]           =      "O"
      tree = TTT_Tree.new(board, "X")
      winning_moves = ["2", "8"]

      result = tree.best_move

      expect(winning_moves).to include(result)
    end

    it "returns an immediate blocking move for X" do
      board[0], board[1], board[2] = "X", "O", "X"
      board[3], board[4], board[5] = "O", "O", "X"
                          board[8] =           "O"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move

      expect(result).to eq("7")
    end

    it "returns an immediate blocking  move for O" do
      board[0], board[1], board[2] = "X", "O", "X"
      board[3], board[4], board[5] = "O", "O", "X"
      board[7]                     =      "X"
      tree = TTT_Tree.new(board, "O")

      result = tree.best_move

      expect(result).to eq("8")
    end

    it "returns blocking move several moves away" do
                board[1]           =      "O"
                board[4]           =      "X"
                board[7]           =      "X"
      tree = TTT_Tree.new(board, "O")
      blocking_moves = ["0", "2", "6", "8"]

      result = tree.best_move

      expect(blocking_moves).to include(result)
    end

  end
end
