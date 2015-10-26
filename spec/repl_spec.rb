require 'rspec'
require 'repl'

RSpec.describe "Repl" do
  it "prints to stdout" do
    repl = Repl.new
    message = "Hello"

    expect{repl.print(message)}.to output(message + "\n").to_stdout
  end

  it "reads from stdin" do
    repl = Repl.new
    message = "Hello"
    allow(repl).to receive(:gets).and_return(message)

    result = repl.read

    expect(result).to eq(message)
  end

  it "prints the board" do
    repl = Repl.new
    board = Board.new
    board_display = "|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n"

    expect{repl.print_board(board)}.to output(board_display).to_stdout
  end
end
