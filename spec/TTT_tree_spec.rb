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
      board[0], board[2], board[3], board[4] = "X", "X", "O", "O"
      tree = TTT_Tree.new(board, "X")

      result = tree.best_move

      expect(result).to eq("1")
    end

    it "returns an immediate blocking move" do
      
    end
  end
end
