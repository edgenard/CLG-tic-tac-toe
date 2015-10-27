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

  it "formats the board for the cli" do
    game = Game.new

    result = game.format_board

    expect(result).to eq("|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n")
  end

  describe "game play" do
    let(:game){ Game.new}

    before(:each) do
      allow(game.repl).to receive(:print).and_return("")
      allow(game.repl).to receive(:clear).and_return(nil)
      allow(game).to receive(:get_human_spot).and_return(4)
      allow(game.player2).to receive(:choose_spot).and_return(3)
      allow(game).to receive(:sleep).and_return(nil)

    end

    it "#start_game calls #play" do
      allow(game).to receive(:play).and_return(nil)

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

    it "colorizes player marks" do
      allow(game.board).to receive(:game_over?).and_return(false, false, false, true)
      allow(game.player1.mark).to receive(:colorize)
      allow(game.player2.mark).to receive(:colorize)

      game.play

      expect(game.player1.mark).to have_received(:colorize)
      expect(game.player2.mark).to have_received(:colorize)
    end
  end


end
