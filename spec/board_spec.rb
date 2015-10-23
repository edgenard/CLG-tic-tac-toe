require 'rspec'
require 'board'


RSpec.describe "Board" do
  it "creates the game board as an array" do
    board = Board.new

    result = board.board

    expect(result).to match(["1", "2", "3", "4", "5", "6", "7", "8"])
  end
end
