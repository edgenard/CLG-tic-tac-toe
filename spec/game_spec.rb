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

    result = game.repl

    expect(result).to be_kind_of(Repl)
  end

  it "allows users to pick game type before starting" do
    game = Game.new
    allow(game.repl).to receive(:print).and_return("")
    allow(game).to receive(:play).and_return(nil)
    allow(game).to receive(:game_type).and_return(nil)
    allow(game).to receive(:choose_markers).and_return(nil)

    game.start_game

    expect(game).to have_received(:game_type)
  end

  it "allows users to choose human vs human game" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("1")
    allow(game.repl).to receive(:print).and_return("")

    game.game_type

    expect(game.player1.human).to be_truthy
    expect(game.player2.human).to be_truthy
  end

  it "allows users to choose a computer vs computer game" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("2")
    allow(game.repl).to receive(:print).and_return("")

    game.game_type

    expect(game.player1.human).to be_falsey
    expect(game.player2.human).to be_falsey
  end

  it "allows users to choose a human vs computer game" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("3")
    allow(game.repl).to receive(:print).and_return("")

    game.game_type

    expect(game.player1.human).to be_truthy
    expect(game.player2.human).to be_falsey
  end

  it "keeps asking until user gives valid game type" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("4", "j", "3")
    allow(game.repl).to receive(:print).and_return("")

    game.game_type

    expect(game.repl).to have_received(:print).with("Please choose 1, 2 or 3").twice
  end

  it "returns a valid human spot" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("4")

    result = game.get_human_spot

    expect(result).to eq(4)
  end

  it "keeps asking until human gives valid spot" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("9", "4")
    allow(game.repl).to receive(:print).and_return(nil)

    result = game.get_human_spot

    expect(game).to have_received(:get_user_choice).twice
    expect(game.repl).to have_received(:print).with("Please choose a valid empty spot.").once
  end

  it "allows users to choose markers before starting" do
    game = Game.new
    allow(game.repl).to receive(:print).and_return("")
    allow(game).to receive(:play).and_return(nil)
    allow(game).to receive(:game_type).and_return(nil)
    allow(game).to receive(:choose_markers).and_return(nil)

    game.start_game

    expect(game).to have_received(:choose_markers)
  end

  it "allows user to choose X marker for player 1" do
    game = Game.new
    allow(game).to receive(:get_user_choice).and_return("1")
    allow(game.repl).to receive(:print).and_return("")

    game.choose_markers

    expect(game.player1.mark).to eq("X")
    expect(game.player2.mark).to eq("O")
  end


  describe "get user choice" do

    it "returns a valid user choice" do
      game = Game.new
      allow(game.repl).to receive(:read).and_return("3")

      result = game.get_user_choice(["1", "2", "3"])

      expect(result).to eq("3")
    end

    it "keeps asking if user gives invalid input" do
      game = Game.new
      allow(game.repl).to receive(:read).and_return("j", " 1", "3")
      allow(game.repl).to receive(:print).and_return("")

      result = game.get_user_choice(["1", "2","3"])

      expect(result).to eq("3")
      expect(game.repl).to have_received(:print).with("Please choose 1, 2 or 3").twice
    end

  end

  describe "game play" do
    let(:game){ Game.new}

    before(:each) do
      allow(game.repl).to receive(:print).and_return("")
      allow(game.repl).to receive(:print_board).and_return(nil)
      allow(game.repl).to receive(:clear).and_return(nil)
      allow(game).to receive(:get_human_spot).and_return(4)
      allow(game).to receive(:sleep).and_return(nil)
      allow(game).to receive(:get_user_choice).and_return("3")
      game.game_type
      allow(game).to receive(:choose_markers).and_return(nil)
      allow(game.player2).to receive(:choose_spot).and_return(3)
    end

    it "#start_game calls #play" do
      allow(game).to receive(:play).and_return(nil)
      allow(game).to receive(:game_type).and_return(nil)

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
      allow(game.board).to receive(:tie?).and_return(false, false, true)

      game.play

      expect(game).to have_received(:get_human_spot).once
      expect(game.player2).to have_received(:choose_spot).once
    end


    it "clears the board for after each round" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)
      allow(game.repl).to receive(:clear)

      game.play

      expect(game.repl).to have_received(:clear).once
    end

    it "prints out each players choice" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)

      game.play

      expect(game.repl).to have_received(:print).with("Player 1 chose 4")
      expect(game.repl).to have_received(:print).with("Player 2 chose 3")
    end
  end
end
