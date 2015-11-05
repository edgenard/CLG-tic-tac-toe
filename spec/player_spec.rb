require 'rspec'
require 'player'

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
    let(:board) { Board.new }
    it "chooses the middle of the board if it is open" do
      board[1], board[5] = 'X', 'O'

      result = player.choose_spot(board)

      expect(result).to eq(4)
    end

    it "blocks other player from winning" do
      board[0], board[1], board[4] = 'O', 'O', 'X'

      result = player.choose_spot(board)

      expect(result).to eq(2)
    end

    it "wins when it can" do
      board[0], board[2], board[3] = 'O', 'O', 'O'
      board[1], board[4] = 'X', 'X'

      result = player.choose_spot(board)

      expect(result).to eq(7)
    end

    it "immediately choooses the only empty spot left" do
      board[0], board[1], board[2] = "X", "O", "X"
      board[3], board[4], board[5] = "O", "O", "X"
      board[6], board[7] = "O", "X"
      allow(player).to receive(:possible_move)

      result = player.choose_spot(board)

      expect(result).to eq(8)
      expect(player).not_to have_received(:possible_move)
    end
  end
end
