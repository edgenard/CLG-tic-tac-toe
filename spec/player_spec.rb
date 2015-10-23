require 'rspec'
require 'player'


RSpec.describe "Player" do
  it "has a mark" do
    player = Player.new('X')

    result = player.mark

    expect(result).to eq('X')
  end

  it "can be human" do
    player = Player.new('X', true)

    result = player.human?

    expect(result).to be true
  end

  it "can be a computer" do
    player = Player.new('X')

    result = player.human?

    expect(result).to be false
  end

  describe "Computer Player" do
    it "chooses the middle of the board if it is open" do
      player = Player.new('X', true)
      board = Board.new
      board[1], board[5] = 'X', 'O'

      result = player.choose_spot(board)

      expect(result).to eq(4)
    end
  end
end
