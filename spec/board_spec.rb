require 'rspec'
require 'board'


RSpec.describe "Board" do
  it "creates a default 3x3 board" do
    board = Board.new
    result = board.state

    expect(result).to match(%w[0 1 2 3 4 5 6 7 8])
  end

  it "creates a 4x4 board" do
    board = Board.new(4)

    result = board.state

    expect(result).to match(%w[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15])
  end

  it "creates a 5x5 board" do
    board = Board.new(5)

    result = board.state

    expect(result).to match(%w[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24])
  end

  it "returns the value of spot on the board" do
    board = Board.new
    result = board[1]

    expect(result).to eq("1")
  end

  it "sets the value at the given index" do
    board = Board.new
    board[1] = "O"

    expect(board[1]).to eq("O")
  end

  describe "3x3 board" do
    let (:board) { Board.new }
    it "game is over if the top row is all O" do
      board[0], board[1], board[2] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if top row is all X" do
      board[0], board[1], board[2] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if middle row is all O" do
      board[3], board[4], board[5] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if middle row is all X" do
      board[3], board[4], board[5] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if bottom row is all O" do
      board[6], board[7], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if bottom row is all X" do
      board[6], board[7], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the first column is all O" do
      board[0], board[3], board[6] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the first column is all X" do
      board[0], board[3], board[6] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the middle column is all O" do
      board[1], board[4], board[7] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the middle column is all X" do
      board[1], board[4], board[7] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the last column is all O" do
      board[2], board[5], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the last column is all X" do
      board[2], board[5], board[8] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the left diagonal is all O" do
      board[0], board[4], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the left diagonal is all X" do
      board[0], board[4], board[8] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the right diagonal is all O" do
      board[2], board[4], board[6] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the right diagonal is all X" do
      board[2], board[4], board[6] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "is a tie if the all places are filled without a winner" do
      board[0], board[1], board[2] = "X", "O", "X"
      board[3], board[4], board[5] = "O", "O", "X"
      board[6], board[7], board[8] = "O", "X", "O"

      result = board.tie?

      expect(result).to be_truthy
    end

    it "is not a tie when X has won" do
      board[0], board[4], board[8] = "X", "X", "X"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "is not a tie when O has won" do
      board[6], board[7], board[8] = "O", "O", "O"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "returns the available spaces" do
      board[1], board[3], board[6] = "X", "O", "X"

      result = board.available_spaces

      expect(result).to match(['0','2','4', '5', '7', '8'])
    end
  end

  describe "4x4 board " do
    let (:board) { Board.new(4)}

    it "game is over if the first row is all O" do
      board[0], board[1], board[2], board[3] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if only some of the first row is O" do
      board[0], board[1], board[2] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if first row is all X" do
      board[0], board[1], board[2], board[3] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if only some of the first is X" do
      board[0], board[1], board[2] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if second row is all O" do
      board[4], board[5], board[6], board[7] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the second row is O" do
      board[4], board[5], board[6] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if second row is all X" do
      board[4], board[5], board[6], board[7] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the second row is X" do
      board[4], board[5], board[6] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if third row is all O" do
      board[8], board[9], board[10], board[11] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of third row is O" do
      board[8], board[9], board[10] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if third row is all X" do
      board[8], board[9], board[10], board[11] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of third row is X" do
      board[8], board[9], board[10] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if fourth row is all O" do
      board[12], board[13], board[14], board[15] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of fourth row is O" do
      board[12], board[13], board[14] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if all of fourth row is X" do
      board[12], board[13], board[14], board[15] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of fourth row is X" do
      board[12], board[13], board[14] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the first column is all O" do
      board[0], board[4], board[8], board[12] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of first colum is O" do
      board[0], board[4], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the first column is all X" do
      board[0], board[4], board[8], board[12] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of first column is X" do
      board[0], board[4], board[8] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the second column is all O" do
      board[1], board[5], board[9], board[13] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of second column is O" do
      board[1], board[5], board[9] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the second column is all X" do
      board[1], board[5], board[9], board[13] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of second column is X" do
      board[1], board[5], board[9] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the third column is all O" do
      board[2], board[6], board[10], board[14] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of third O" do
      board[2], board[6], board[10] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the third column is all X" do
      board[2], board[6], board[10], board[14] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of third column is X" do
      board[2], board[6], board[10] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the fourth column is all O" do
      board[3], board[7], board[11], board[15] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of fourth column is O" do
      board[3], board[7], board[11] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the fourth column is all X" do
      board[3], board[7], board[11], board[15] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of fourth column is X" do
      board[3], board[7], board[11] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the right diagonal is all O" do
      board[3], board[6], board[9], board[12] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not  over if some of right diagonal is O" do
      board[3], board[6], board[9] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the right diagonal is all X" do
      board[3], board[6], board[9], board[12] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not  over if some of right diagonal is X" do
      board[3], board[6], board[9] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the left diagonal is all O" do
      board[0], board[5], board[10], board[15] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the left diagonal is O" do
      board[0], board[5], board[10] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the left diagonal is all X" do
      board[0], board[5], board[10], board[15] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the left diagonal is X" do
      board[0], board[5], board[10] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is a tie if the all places are filled without a winner" do
      board[0], board[1], board[2], board[3]     = "X", "O", "X", "O"
      board[4], board[5], board[6], board[7]     = "O", "O", "X", "X"
      board[8], board[9], board[10], board[11]   = "O", "X", "O", "O"
      board[12], board[13], board[14], board[15] = "O", "X", "X", "O"

      result = board.tie?

      expect(result).to be_truthy
    end

    it "is not a tie when X has won" do
      board[0], board[4], board[8], board[12] = "X", "X", "X", "X"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "is not a tie when O has won" do
      board[3], board[6], board[9], board[12] = "O", "O", "O", "O"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "returns the available spaces" do
      board[1], board[3], board[6], board[10] = "X", "O", "X", "O"

      result = board.available_spaces

      expect(result).to match(%w[0 2 4 5 7 8 9 11 12 13 14 15 ])
    end
  end
end
