require 'rspec'
require 'game'

RSpec.describe "Game" do

  it "creates a new board when initialized" do
    game = Game.new
    result = game.board

    expect(result).to be_kind_of(Board)
  end

  it "creates two players when initialized" do
    game = Game.new

    player1 = game.player1
    player2 = game.player2

    expect(player1).to be_kind_of(Player)
    expect(player2).to be_kind_of(Player)
  end

  it "creates a new repl when initialized" do
    game = Game.new

    result = game.instance_variable_get("@repl")

    expect(result).to be_kind_of(Repl)
  end


end
