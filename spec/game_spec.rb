require 'rspec'
require 'game'

RSpec.describe "Game" do
  it "makes a new game" do
    game = Game.new

    expect(game).to be_kind_of(Game)
  end

  it "creates a new board when initialized" do
    game = Game.new

    result = game.board

    expect(result).to be_kind_of(Board)
  end



  it "blocks human from winning" do
    game = Game.new
    board = ["X", "1", "2", "O", "O", "5", "6", "7", "8"]

    result = game.get_best_move(board, "X")

    expect(result).to be 5
  end

  it "wins when it can" do
    game = Game.new
    board = ["O", "O", "X", "3", "X", "O", "6", "7", "8"]

    result = game.get_best_move(board, "X")

    expect(result).to be 6
  end

  it "picks any available space when it can't win or lose" do
    game = Game.new
    board = ["0", "1", "2", "3", "O", "5", "6", "7", "8"]

    best_move = game.get_best_move(board, "X")
    result = [0, 1, 2, 3, 5, 6, 7, 8].include? best_move

    expect(result).to be true
  end

  it "picks the middle of the board if available" do
    game = Game.new

    game.eval_board

    expect(game.board[4]).to eq "X"
  end

end
