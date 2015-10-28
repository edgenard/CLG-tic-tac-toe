require 'rspec'
require 'game'
require 'byebug'

RSpec.describe "Game" do

  it "creates a new board when initialized" do
    game = Game.new

    result = game.board

    expect(result).to be_kind_of(Board)
  end


  it "creates a new repl when initialized" do
    game = Game.new

    result = game.instance_variable_get("@repl")

    expect(result).to be_kind_of(Repl)
  end

  it "allows users to pick players before starting to play" do
    game = Game.new
    allow(game.repl).to receive(:print).and_return("")
    allow(game.repl).to receive(:print_board).and_return("")
    allow(game).to receive(:play).and_return(nil)
    allow(game).to receive(:pick_players).and_return(nil)

    game.start_game

    expect(game).to have_received(:pick_players)
  end

  it "allows users to choose human vs human game" do
    game = Game.new
    allow(game.repl).to receive(:read).and_return("1")
    allow(game.repl).to receive(:print).and_return("")

    game.pick_players

    expect(game.player1.human?).to be true
    expect(game.player2.human?).to be true
  end

  it "allows users to choose a computer vs computer game" do
    game = Game.new
    allow(game.repl).to receive(:read).and_return("2")
    allow(game.repl).to receive(:print).and_return("")

    game.pick_players

    expect(game.player1.human?).to be false
    expect(game.player2.human?).to be false
  end

  it "allows users to choose a human vs computer game" do
    game = Game.new
    allow(game.repl).to receive(:read).and_return("3")
    allow(game.repl).to receive(:print).and_return("")

    game.pick_players

    expect(game.player1.human?).to be true
    expect(game.player2.human?).to be false
  end

  describe "game play" do
    let(:game){ Game.new}

    before(:each) do
      game.player1 = Player.new("O", true)
      game.player2 = Player.new("X")
      allow(game.repl).to receive(:print).and_return("")
      allow(game.repl).to receive(:clear).and_return(nil)
      allow(game).to receive(:get_human_spot).and_return(4)
      allow(game.player2).to receive(:choose_spot).and_return(3)
      allow(game).to receive(:sleep).and_return(nil)
    end

    it "#start_game calls #play" do
      allow(game).to receive(:play).and_return(nil)
      allow(game).to receive(:pick_players).and_return(nil)
      game.start_game

      expect(game).to have_received(:play)
    end

    it "plays until someone wins" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)

      game.play

      expect(game).to have_received(:get_human_spot).once
      expect(game.player2).to have_received(:choose_spot).once
    end

    it "stops playing if there is a tie" do
      allow(game.board).to receive(:tie?).and_return(false, false,false, true)

      game.play

      expect(game).to have_received(:get_human_spot).once
      expect(game.player2).to have_received(:choose_spot).once
    end


    it "clears the board for after each turn" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)
      allow(game.repl).to receive(:clear)

      game.play

      expect(game.repl).to have_received(:clear).once
    end

    it "notifies the user of computer choice" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)

      game.play

      expect(game.repl).to have_received(:print).with("Player 2 chose 3")
    end

    it "sleeps between turns" do
      allow(game.board).to receive(:game_over?).and_return(false, false, false, true)

      game.play

      expect(game).to have_received(:sleep).twice
    end
  end


end
