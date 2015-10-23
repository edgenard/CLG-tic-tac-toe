require 'rspec'
require 'game'

RSpec.describe "Game" do

  it "#state returns the state of the game as an array" do
    game = Game.new

    result = game.state

    expect(result).to match(['0','1', '2', '3', '4', '5', '6', '7', '8'])
  end



  it "blocks human from winning" do
    game = Game.new
    board = game.board
    board[0], board[3], board[4] = 'X', 'O', 'O'

    result = game.get_best_move(board.state, "X")

    expect(result).to be 5
  end

  it "wins when it can" do
    game = Game.new
    board = game.board
    board[0], board[1], board[2] = 'O', 'O', 'X'
    board[4], board[5] = 'X', 'O'


    result = game.get_best_move(board.state, "X")

    expect(result).to be 6
  end

  it "picks any available space when it can't win or lose" do
    game = Game.new
    board = game.board
    board[4] = 'O'

    best_move = game.get_best_move(board.state, "X")
    result = [0, 1, 2, 3, 5, 6, 7, 8].include? best_move

    expect(result).to be true
  end

  it "picks the middle of the board if available" do
    game = Game.new

    game.eval_board

    expect(game.board[4]).to eq "X"
  end

end
