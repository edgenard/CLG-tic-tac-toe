require 'rspec'
require 'player'
require 'board'

RSpec.describe "Player" do
  let(:player) { Player.new(mark: "X") }
  it "has a mark" do
    result = player.mark

    expect(result).to eq('X')
  end

  it "mark can be changed" do
    player.mark = "O"

    expect(player.mark).to eq("O")
  end

  it "can be human" do
    player.human = true

    result = player.human

    expect(result).to be_truthy
  end

  it "can be a computer" do
    result = player.human

    expect(result).to be_falsy
  end

  it "human attribute can be changed" do
    player.human = true

    expect(player.human).to be_truthy
  end

  describe "Computer Player" do
    it "chooses the center of 3x3 board if open" do
      board = Board.new
      board[1], board[5] = 'X', 'O'

      result = player.choose_spot(board)

      expect(result).to eq(4)
    end

    it "chooses the center spot of 4x4 board if open" do
      board = Board.new(4)

      result = player.choose_spot(board)

      expect(result).to eq(10)
    end

    it "chooses the center spot on a 5x5 board if open" do
      board = Board.new(5)

      result = player.choose_spot(board)

      expect(result).to eq(12)
    end

    it "blocks other player from winning on 3x3 board" do
      board = Board.new
      board[0], board[1], board[4] = 'O', 'O', 'X'

      result = player.choose_spot(board)

      expect(result).to eq(2)
    end

    it "blocks other player from winning on 4x4 board" do
      board = Board.new(4)
      board[10], board[15] = "X", "X"
      board[0], board[1], board[2] = "O", "O", "O"

      result = player.choose_spot(board)

      expect(result).to eq(3)
    end

    it "blocks other player from winning on 5x5 board" do
      board = Board.new(5)
      board[12], board[8], board[5] = "X", "X", "X"
      board[1], board[6], board[11], board[16] = "O", "O", "O", "O"

      result = player.choose_spot(board)

      expect(result).to eq(21)
    end

    it "wins when it can on 3x3 board" do
      board = Board.new
      board[0], board[2], board[3] = 'O', 'O', 'O'
      board[1], board[4] = 'X', 'X'

      result = player.choose_spot(board)

      expect(result).to eq(7)
    end

    it "wins when it can on 4x4 board" do
      board = Board.new(4)
      board[0], board[5], board[10] = "X", "X", "X"
      board[3], board[6], board[9] = "O", "O", "O"

      result = player.choose_spot(board)

      expect(result).to eq(15)
    end

    it "wins when it can on 5x5 board" do
      board = Board.new(5)
      board[10], board[11], board[12], board[13] = "X", "X", "X", "X"
      board[5], board[6], board[7], board[8] = "O", "O", "O","O"

      result = player.choose_spot(board)

      expect(result).to eq(14)
    end

    it "immediately choooses the only empty spot left on 3x3 board" do
      board = Board.new
      board[0], board[1], board[2] = "X", "O", "X"
      board[3], board[4], board[5] = "O", "O", "X"
      board[6], board[7] = "O", "X"
      allow(player).to receive(:possible_move)

      result = player.choose_spot(board)

      expect(result).to eq(8)
      expect(player).not_to have_received(:possible_move)
    end
    it "immediately choooses the only empty spot left on 4x4 board" do
      board = Board.new(4)
      board[0], board[1], board[2], board[3]   = "X", "O", "X", "O"
      board[4], board[5], board[6], board[7]   = "O", "O", "X", "X"
      board[8], board[9], board[10], board[11] = "O", "X", "O", "X"
      board[12], board[13], board[14]          = "X", "O", "O"
      allow(player).to receive(:possible_move)

      result = player.choose_spot(board)

      expect(result).to eq(15)
      expect(player).not_to have_received(:possible_move)
    end

    it "immediately choooses the only empty spot left on 5x5 board" do
      board = Board.new(5)
      board[0], board[1], board[2], board[3], board[4]      = "X", "O", "X", "O", "X"
      board[5], board[6], board[7], board[8], board[9]      = "O", "O", "X", "X", "O"
      board[10], board[11], board[12], board[13], board[14] = "O", "X", "O", "X", "O"
      board[15], board[16], board[17], board[18], board[19] = "X", "O", "O", "X", "O"
      board[20], board[21], board[22], board[23]            = "O", "X", "O", "O"
      allow(player).to receive(:possible_move)

      result = player.choose_spot(board)

      expect(result).to eq(24)
      expect(player).not_to have_received(:possible_move)
    end
  end
end
