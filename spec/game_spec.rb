require 'rspec'
require 'game'
require 'byebug'

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

  it "plays until someone wins" do
    game = Game.new
    allow(game).to receive(:get_human_spot).and_return("4")
    allow(game.board).to receive(:game_over?).and_return(false, false,false, true)
    allow(game.player2).to receive(:choose_spot).and_return(3)
    allow(game.repl).to receive(:print).and_return("")

    game.play

    expect(game).to have_received(:get_human_spot).once
    expect(game.player2).to have_received(:choose_spot).once
  end
end
