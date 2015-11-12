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

    it "returns an immediate winning" do
      board[0], board[2], board[3], board[4] = "O", "O", "X", "X"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move

      expect(result).to eq("5")
    end

    it "returns a winning move several moves away" do
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
