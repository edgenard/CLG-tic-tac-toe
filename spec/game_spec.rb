require 'rspec'
require 'game'

RSpec.describe "Game" do

  it "creates a new board when initialized" do
    game = Game.new

    result = game.instance_variable_get("@board")

    expect(result).to be_kind_of(Board)
  end

  it "creates two players when initialized" do
    game = Game.new

    player1 = game.instance_variable_get("@player1")
    player2 = game.instance_variable_get("@player2")

    expect(player1).to be_kind_of(Player)
    expect(player2).to be_kind_of(Player)
  end

  it "creates a new repl when initialized" do
    game = Game.new

    result = game.instance_variable_get("@repl")

    expect(result).to be_kind_of(Repl)
  end

  it "plays until someone wins" do
    game = Game.new
    board = double("board")
    allow(game).to receive(:get_human_spot).and_return("4")
    allow(board).to receive(:game_over?).and_return(false, true)

    game.play

    expect(game).to receive(:get_human_spot).once
  end
end
