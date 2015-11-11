require 'rspec'
require 'TTT_tree'

RSpec.describe "TTT_tree" do
  it "builds a list of children" do
    board = Board.new
    tree = TTT_Tree.new(board, "X")

    result = tree.children

    expect(result.length).to eq(9)
  end
end
