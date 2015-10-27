require 'rspec'
require 'repl'

RSpec.describe "Repl" do
  it "prints to stdout" do
    repl = Repl.new
    message = "Hello"

    expect{repl.print(message)}.to output("\n" + message + "\n").to_stdout
  end

  it "reads from stdin" do
    repl = Repl.new
    message = "Hello"
    allow(repl).to receive(:gets).and_return(message)

    result = repl.read

    expect(result).to eq(message)
  end

  it "clears the console" do
    repl = Repl.new
    system = double("system")
    allow(repl).to receive(:system)

    repl.clear

    expect(repl).to have_received(:system)
  end

  it "prints the board to stdout" do
    repl = Repl.new
    board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    formatted_board = "|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n"


    expect{repl.print_board(board)}.to output("\n"+formatted_board).to_stdout
  end
 end
