require 'rspec'
require 'game'

RSpec.describe "Game" do

  it "#board returns the board as an array" do
    game = Game.new

    result = game.board

    expect(result).to match(['0','1', '2', '3', '4', '5', '6', '7', '8'])
  end



  xit "blocks human from winning" do
    game = Game.new
    board = ["X", "1", "2", "O", "O", "5", "6", "7", "8"]

    result = game.get_best_move(board, "X")

    expect(result).to be 5
  end

  xit "wins when it can" do
    game = Game.new
    board = ["O", "O", "X", "3", "X", "O", "6", "7", "8"]

    result = game.get_best_move(board, "X")

    expect(result).to be 6
  end

  xit "picks any available space when it can't win or lose" do
    game = Game.new
    board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]

    best_move = game.get_best_move(board, "X")
    result = [0, 1, 2, 3, 5, 6, 7, 8].include? best_move

    expect(result).to be true
  end

  xit "picks the middle of the board if available" do
    game = Game.new

    game.eval_board

    expect(game.board[4]).to eq "X"
  end

end
