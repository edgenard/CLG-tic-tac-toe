require 'rspec'
require 'message'

RSpec.describe "Message" do
  let(:message) { Message.new}

  it "has a welcome message" do
    result = message.welcome

    expect(result).to eq("Welcome to my Tic Tac Toe game!")
  end

  it "has a select spot message" do
    result = message.select_spot

    expect(result).to eq("Please select your spot.")
  end

  it "has a game over message" do
    result = message.game_over

    expect(result).to eq("Game over.")
  end

  it "has a player choice message" do
    result = message.player_choice(player:"1", choice:"4")

    expect(result).to eq("Player 1 chose 4")
  end

  it "has an invalid player choice message" do
    result = message.invalid_player_choice(["1", "2" ,"3"])

    expect(result).to eq("Please choose 1, 2 or 3")
  end

  it "has a game type messsage" do
    result = message.game_type

    expect(result).to eq("Please choose the type of game you would like to play. \nChoose 1 for Human vs Human. Choose 2 for Computer vs Computer. Choose 3 for Human vs Computer")
  end

  it "has a choose marker message" do
    result = message.choose_marker

    expect(result).to eq("Please choose the marker for Player 1. \n Choose 1 for X. \n Choose 2 for O.")
  end

  it "has a choose order message" do
    result = message.choose_order

    expect(result).to eq("Please choose which player goes first. \nChoose 1 for Player 1. \nChoose 2 for Player 2")
  end

  it "has a message to choose board size" do
    result = message.choose_board_size

    expect(result).to eq("Please choose the size of the board you'd like to play on.\n Choose 1 for 3x3 board.\n Choose 2 for 4x4 board.\n Choose 3 for 5x5 board")
  end

  describe "formatting boards" do
    it "formats a 3x3 board" do
      rows = [["0", "1", "2"], ["3", "4", "5"], ["6", "7", "8"]]
      formatted_board =
      "|  0  |  1  |  2  |\n|  3  |  4  |  5  |\n|  6  |  7  |  8  |\n"


      result = message.format_board(rows)

      expect(result).to eq(formatted_board)
    end

    it "formats a 4x4 board" do
      rows = [["0", "1", "2", "3"],
               ["4", "5", "6", "7"],
               ["8", "9", "10", "11"],
              ["12", "13", "14", "15"]
            ]

      formatted_board ="|  0  |  1  |  2  |  3  |\n|  4  |  5  |  6  |  7  |\n|  8  |  9  |  10 |  11 |\n|  12 |  13 |  14 |  15 |\n"


      result = message.format_board(rows)

      expect(result).to eq(formatted_board)
    end

    it "formates a 5x5 board" do
      rows = [["0","1","2", "3", "4"], ["5", "6", "7", "8", "9"], ["10", "11", "12", "13", "14"], ["15", "16", "17", "18",  "19"], ["20", "21","22", "23", "24"]]

      formatted_board ="|  0  |  1  |  2  |  3  |  4  |\n|  5  |  6  |  7  |  8  |  9  |\n|  10 |  11 |  12 |  13 |  14 |\n|  15 |  16 |  17 |  18 |  19 |\n|  20 |  21 |  22 |  23 |  24 |\n"
    end
  end

  it "colors X green, O red" do
    test_string = "X and O"
    x_mark = "X".colorize(:green)
    o_mark = "O".colorize(:red)
    colorized_message = "#{x_mark} and #{o_mark}"

    result = message.colorize_markers(test_string)

    expect(result).to eq(colorized_message)
  end

  it "returns a colorized board" do
  rows = [["0","1","X", "O", "4"], ["5", "6", "7", "8", "9"], ["10", "11", "12", "13", "X"], ["O", "16", "17", "18",  "19"], ["20", "21","22", "23", "24"]]
    x_mark = "X".colorize(:green)
    o_mark = "O".colorize(:red)
    colorized_board ="|  0  |  1  |  #{x_mark}  |  #{o_mark}  |  4  |\n|  5  |  6  |  7  |  8  |  9  |\n|  10 |  11 |  12 |  13 |  #{x_mark}  |\n|  #{o_mark}  |  16 |  17 |  18 |  19 |\n|  20 |  21 |  22 |  23 |  24 |\n"

    result = message.colorize_board(rows)

    expect(result).to eq(colorized_board)
  end


end
