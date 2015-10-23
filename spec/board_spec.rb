require 'rspec'
require 'board'


RSpec.describe "Board" do
  it "creates the game board as an array" do
    board = Board.new

    result = board.board

    expect(result).to match(["0", "1", "2", "3", "4", "5", "6", "7", "8"])
  end

  it "displays the board" do
    board = Board.new

    result = board.display

    expect(result).to eq("|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n")
  end

  it "returns the value of spot on the board" do
    board = Board.new

    result = board[0]

    expect(result).to eq("0")
  end

  it "sets the value at the given index" do
    board = Board.new

    board[1] = "O"

    expect(board[1]).to eq("O")
  end

  it "game is over if the top row is all O" do
    board = Board.new
    board[0], board[1], board[2] = "O", "O", "O"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if top row is all X" do
    board = Board.new
    board[0], board[1], board[2] = "X", "X", "X"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if middle row is all O" do
    board = Board.new
    board[3], board[4], board[5] = "O", "O", "O"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if middle row is all X" do
    board = Board.new
    board[3], board[4], board[5] = "X", "X", "X"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if bottom row is all O" do
    board = Board.new
    board[6], board[7], board[8] = "O", "O", "O"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if bottom row is all X" do
    board = Board.new
    board[6], board[7], board[8] = "O", "O", "O"

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the first column is all O" do
    board = Board.new
    board[0], board[3], board[6] = 'O', 'O', 'O'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the first column is all X" do
    board = Board.new
    board[0], board[3], board[6] = 'X', 'X', 'X'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the middle column is all O" do
    board = Board.new
    board[1], board[4], board[7] = 'O', 'O', 'O'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the middle column is all X" do
    board = Board.new
    board[1], board[4], board[7] = 'X', 'X', 'X'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the last column is all O" do
    board = Board.new
    board[2], board[5], board[8] = 'O', 'O', 'O'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the last column is all X" do
    board = Board.new
    board[2], board[5], board[8] = 'X', 'X', 'X'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the left diagonal is all O" do
    board = Board.new
    board[0], board[4], board[8] = 'O', 'O', 'O'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the left diagonal is all X" do
    board = Board.new
    board[0], board[4], board[8] = 'X', 'X', 'X'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the right diagonal is all O" do
    board = Board.new
    board[2], board[4], board[6] = 'O', 'O', 'O'

    result = board.game_over?

    expect(result).to be true
  end

  it "game is over if the right diagonal is all X" do
    board = Board.new
    board[2], board[4], board[6] = 'X', 'X', 'X'

    result = board.game_over?

    expect(result).to be true
  end

  it "is a tie if the all places are filled without a winner" do
    board = Board.new
    board[0], board[1], board[2] = 'X', 'O', 'X'
    board[3], board[4], board[5] = 'O', 'O', 'X'
    board[6], board[7], board[8] = 'O', 'X', 'O'

    result = board.tie?

    expect(result).to be true  
  end




end
