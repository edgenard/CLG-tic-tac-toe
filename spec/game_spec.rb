require 'rspec'
require 'game'

RSpec.describe "Game" do
  it "makes a new game" do
    game = Game.new

    expect(game).to be_kind_of(Game)
  end

  it "is over if the top row is all O" do
    game = Game.new
    board = ["O", "O", "O","3", "4", "5", "6" "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if the top row is all X" do
    game = Game.new
    board = ["X", "X", "X","3", "4", "5", "6" "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if the middle row is all O" do
    game = Game.new
    board = ["0", "1", "2","O", "O", "O", "6" "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if the middle row is all X" do
    game = Game.new
    board = ["0", "1", "2","X", "X", "X", "6" "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if the bottom row is all O" do
    game = Game.new
    board = ["0", "1", "2", "3", "4", "5", "O", "O", "O"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if the bottom row is all X" do
    game = Game.new
    board = ["0", "1", "2", "3", "4", "5", "X", "X", "X"]

    result = game.game_is_over(board)

    expect(result).to be true
  end


  it "is over if first column is all O" do
    game = Game.new
    board = ["O", "1", "2", "O", "4", "5", "O", "7","8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if first column is all X" do
    game = Game.new
    board = ["X", "1", "2", "X", "4", "5", "X", "7","8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if middle column is all O" do
    game = Game.new
    board = ["0", "O", "2", "3", "O", "5", "6", "O","8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if middle column is all X" do
    game = Game.new
    board = ["0", "X", "2", "3", "X", "5", "6", "X","8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if last column is all O" do
    game = Game.new
    board = ["0", "1", "O", "3", "4", "O", "6", "7","O"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if last column is all X" do
    game = Game.new
    board = ["0", "1", "X", "3", "4", "X", "6", "7","X"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if left diagonal is all O" do
    game = Game.new
    board = ["O", "1", "2", "3", "O", "5", "6" , "7", "O"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if left diagonal is all X" do
    game = Game.new
    board = ["X", "1", "2", "3", "X", "5", "6" , "7", "X"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if right diagonal is all O" do
    game = Game.new
    board = ["0", "1", "O", "3", "O", "5", "O" , "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is over if right diagonal is all X" do
    game = Game.new
    board = ["0", "1", "X", "3", "X", "5", "X" , "7", "8"]

    result = game.game_is_over(board)

    expect(result).to be true
  end

  it "is a tie when all the spaces are filled" do
    game = Game.new
    board = ["O", "O", "X", "X", "X", "O", "O","O", "X"]

    result = game.tie(board)

    expect(result).to be true
  end

  it "is not a tie when X has won" do
    game = Game.new
    board = ["X", "O", "X", "O", "X", "O", "X","7", "O"]

    result = game.tie(board)

    expect(result).to be false
  end

  it "is not a tie when O has won" do
    game = Game.new
    board=["O", "X", "O", "X", "O", "X", "O", "7", "X"]

    result = game.tie(board)

    expect(result).to be false
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
