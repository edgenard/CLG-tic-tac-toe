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
      board[0], board[4], board[7], board[5] = "X", "X", "O", "O"
      tree = TTT_Tree.new(board, "X")

      result = tree.winning_move("X")

      expect(result).to eq("8")
    end

    it "returns the immediate winning_move for player O" do
      board[0], board[4], board[2], board[5] = "X", "X", "O", "O"
      tree = TTT_Tree.new(board, "O")

      result = tree.winning_move("O")

      expect(result).to eq("8")
    end

    xit "returns a winning move several moves away" do
      board[0], board[4], board[5] = "O","X", "O"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move
      p result
      expect(["0", "2", "6", "8"]).to include(result)
    end

    xit "returns an immediate blocking move" do
      board[0], board[4], board[5], board[8] = "X", "O", "O", "X"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move

      expect(result).to eq("3")
    end
  end
end
