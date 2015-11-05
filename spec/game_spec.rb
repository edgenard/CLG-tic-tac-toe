require 'rspec'
require 'game'
require 'byebug'

RSpec.describe "Game" do
  let(:game) { Game.new }
  it "creates a new board when initialized" do
    result = game.board

    expect(result).to be_kind_of(Board)
  end

  it "creates a new input_output when initialized" do
    result = game.input_output

    expect(result).to be_kind_of(InputOutput)
  end

  describe "game type" do
    before(:each) do
      allow(game.input_output).to receive(:print).and_return("")
    end

    it "allows users to choose human vs human game" do
      allow(game).to receive(:get_user_choice).and_return("1")

      game.game_type

      expect(game.player1.human).to be_truthy
      expect(game.player2.human).to be_truthy
    end

    it "allows users to choose a computer vs computer game" do
      allow(game).to receive(:get_user_choice).and_return("2")

      game.game_type

      expect(game.player1.human).to be_falsey
      expect(game.player2.human).to be_falsey
    end

    it "allows users to choose a human vs computer game" do
      allow(game).to receive(:get_user_choice).and_return("3")

      game.game_type

      expect(game.player1.human).to be_truthy
      expect(game.player2.human).to be_falsey
    end
  end


  it "allows user to choose X marker for player 1" do
    allow(game).to receive(:get_user_choice).and_return("1")
    allow(game.input_output).to receive(:print).and_return("")

    game.choose_markers

    expect(game.player1.mark).to eq("X")
    expect(game.player2.mark).to eq("O")
  end

  it "allows user to decide who goes first" do
    allow(game).to receive(:get_user_choice).and_return("2")
    allow(game.input_output).to receive(:print).and_return("")
    game.player1.mark = "X"
    game.player2.mark = "O"

    game.choose_order

    expect(game.player1.mark).to eq("O")
    expect(game.player2.mark).to eq("X")
  end

  describe "get user choice" do
    it "returns a valid user choice" do
      allow(game.input_output).to receive(:read).and_return("3")

      result = game.get_user_choice(["1", "2", "3"])

      expect(result).to eq("3")
    end

    it "keeps asking if user gives invalid input" do
      allow(game.input_output).to receive(:read).and_return("j", " 1", "3")
      allow(game.input_output).to receive(:print).and_return("")

      result = game.get_user_choice(["1", "2","3"])

      expect(result).to eq("3")
      expect(game.input_output).to have_received(:print).with("Please choose 1, 2 or 3").twice
    end
  end

  it "#get_player_spot returns a computer players choice" do
    game.player1.human = false
    allow(game.player1).to receive(:choose_spot).and_return(4)

    result = game.get_player_spot(game.player1)

    expect(game.player1).to have_received(:choose_spot)
    expect(result).to eq(4)
  end

  it "returns a human players choice" do
    game.player1.human = true
    allow(game).to receive(:get_user_choice).and_return("4")

    result = game.get_player_spot(game.player1)

    expect(game).to have_received(:get_user_choice)
    expect(result).to eq(4)
  end

  describe "game play" do
    before(:each) do
      allow(game.input_output).to receive(:print).and_return("")
      allow(game.input_output).to receive(:clear).and_return(nil)
      allow(game).to receive(:get_player_spot).and_return(4, 3)
    end

    it "plays until someone wins" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)

      game.play

      expect(game).to have_received(:get_player_spot).twice
    end

    it "stops playing if there is a tie" do
      allow(game.board).to receive(:tie?).and_return(false, false, true)

      game.play

      expect(game).to have_received(:get_player_spot).twice
    end


    it "clears the board for after each round" do
      allow(game.board).to receive(:game_over?).and_return(false, false,false, true)
      allow(game.input_output).to receive(:clear)

      game.play

      expect(game.input_output).to have_received(:clear).once
    end

    it "prints out each players choice" do
      allow(game.board).to receive(:game_over?).and_return(false, false, false, true)

      game.play

      expect(game.input_output).to have_received(:print).with("Player 1 chose 4")
      expect(game.input_output).to have_received(:print).with("Player 2 chose 3")
    end
  end
end
