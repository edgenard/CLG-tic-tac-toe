require 'rspec'
require 'board'
require 'byebug'


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
    it "returns the rows" do
      rows = [["0","1","2"], ["3", "4", "5"], ["6", "7", "8"]]

      result = board.rows

      expect(result).to match(rows)
    end
    it "returns the columns" do
      columns = [["0", "3", "6"], ["1", "4", "7"], ["2", "5", "8"]]

      result = board.columns

      expect(result).to match(columns)
    end

    it "returns the diagonals" do
      diagonals = [["0", "4", "8"], ["2", "4", "6"]]

      result = board.diagonals

      expect(result).to match(diagonals)
    end

    it "game is over if a row is all one value" do
      board[0], board[1], board[2] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if a column is all one value" do
      board[1], board[4], board[7] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the left diagonal is all one value" do
      board[0], board[4], board[8] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is over if the right diagonal is all one value" do
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

    it "is not a tie when a player has one" do
      board[0], board[4], board[8] = "X", "X", "X"

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

    it "returns the rows" do
      rows = [["0","1","2", "3"], ["4", "5", "6", "7"], ["8", "9", "10", "11"], ["12", "13", "14", "15"]]

      result = board.rows

      expect(result).to match(rows)
    end
    it "returns the columns" do
      columns = [["0", "4", "8", "12"], ["1", "5", "9", "13"], ["2", "6", "10", "14"], ["3", "7", "11", "15"]]

      result = board.columns

      expect(result).to match(columns)
    end

    it "returns the diagonals" do
      diagonals = [["0", "5", "10", "15"], ["3", "6", "9", "12"]]

      result = board.diagonals

      expect(result).to match(diagonals)
    end

    it "game is over if a row  is all one value" do
      board[0], board[1], board[2], board[3] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if only some of a row is one value" do
      board[0], board[1], board[2] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end


    it "game is over if a column is all one value" do
      board[3], board[7], board[11], board[15] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of a column is one value" do
      board[3], board[7], board[11] = "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the right diagonal is one value" do
      board[3], board[6], board[9], board[12] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not  over if some of right diagonal is one value" do
      board[3], board[6], board[9] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if the left diagonal is all one value" do
      board[0], board[5], board[10], board[15] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the left diagonal is one value" do
      board[0], board[5], board[10] = "O", "O", "O"

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

    it "is not a tie when a player has won" do
      board[0], board[4], board[8], board[12] = "X", "X", "X", "X"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "returns the available spaces" do
      board[1], board[3], board[6], board[10] = "X", "O", "X", "O"

      result = board.available_spaces

      expect(result).to match(%w[0 2 4 5 7 8 9 11 12 13 14 15 ])
    end
  end

  describe "5x5 board " do
    let (:board) { Board.new(5)}

    it "returns the rows" do
      rows = [["0","1","2", "3", "4"], ["5", "6", "7", "8", "9"], ["10", "11", "12", "13", "14"], ["15", "16", "17", "18",  "19"], ["20", "21","22", "23", "24"]]

      result = board.rows

      expect(result).to match(rows)
    end
    it "returns the columns" do
      columns = rows = [["0","5","10", "15", "20"], ["1", "6", "11", "16", "21"], ["2", "7", "12", "17", "22"], ["3", "8", "13", "18",  "23"], ["4", "9","14", "19", "24"]]

      result = board.columns

      expect(result).to match(columns)
    end

    it "returns the diagonals" do
      diagonals = [["0", "6", "12", "18", "24"], ["4", "8", "12", "16", "20"]]

      result = board.diagonals

      expect(result).to match(diagonals)
    end

    it "game is over if a row  is all one value" do
      board[0], board[1], board[2], board[3], board[4] = "O", "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if only some of a row is one value" do
      board[0], board[1], board[2], board[3] = "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if a column is all one value" do
      board[3], board[8], board[13], board[18], board[23] = "X", "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of a column is one value" do
      board[3], board[8], board[13], board[18] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if  all the right diagonal is one value" do
      board[4], board[8], board[12], board[16], board[20] = "O", "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not  over if some of right diagonal is one value" do
      board[4], board[8], board[12], board[16] = "O", "O", "O", "O"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is over if all of the left diagonal is all one value" do
      board[0], board[6], board[12], board[18], board[24] = "X", "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_truthy
    end

    it "game is not over if some of the left diagonal is one value" do
      board[0], board[6], board[12], board[18] = "X", "X", "X", "X"

      result = board.game_over?

      expect(result).to be_falsy
    end

    it "game is a tie if the all places are filled without a winner" do
      board[0], board[1], board[2], board[3], board[4]      = "X", "O", "X", "O", "X"
      board[5], board[6], board[7], board[8], board[9]      = "O", "O", "X", "X", "O"
      board[10], board[11], board[12], board[13], board[14] = "O", "X", "O", "O", "X"
      board[15], board[16], board[17], board[18], board[19] = "O", "X", "X", "O", "X"
      board[20], board[21], board[22], board[23], board[24] = "X", "O", "O", "O", "X"

      result = board.tie?

      expect(result).to be_truthy
    end

    it "is not a tie when a player has won" do
      board[0], board[6], board[12], board[18], board[24] = "X", "X", "X", "X", "X"

      result = board.tie?

      expect(result).to be_falsy
    end

    it "returns the available spaces" do
      board[1], board[13], board[16], board[15], board[22] = "X", "O", "X", "O", "O"

      result = board.available_spaces

      expect(result).to match(%w[0 2 3 4 5 6 7 8 9 10 11 12 14 17 18 19 20 21 23 24 ])
    end
  end
end
