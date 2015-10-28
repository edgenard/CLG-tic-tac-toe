require 'rspec'
require 'repl'

RSpec.describe "Repl" do
  let(:repl) {  Repl.new}
  before(:each) do
    allow(repl).to receive(:sleep).and_return(nil)
  end
  it "prints to stdout" do
    message = "Hello"

    expect{repl.print(message)}.to output("\n" + message + "\n").to_stdout
  end

  it "slows down the printing of messages" do
    allow(repl).to receive(:puts).and_return(nil)

    repl.print("Hello")

    expect(repl).to have_received(:sleep)
  end

  it "reads from stdin" do
    message = "Hello"
    allow(repl).to receive(:gets).and_return(message)

    result = repl.read

    expect(result).to eq(message)
  end

  it "clears the console with 1 second delay" do
    system = double("system")
    allow(repl).to receive(:system)

    repl.clear

    expect(repl).to have_received(:sleep).with(1)
    expect(repl).to have_received(:system).with("clear")
  end

  it "prints the board to stdout" do
    board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    formatted_board = "|_0_|_1_|_2_|\n|_3_|_4_|_5_|\n|_6_|_7_|_8_|\n"


    expect{repl.print_board(board)}.to output("\n"+formatted_board).to_stdout
  end

  it "colorizes X and O" do
    o_mark = "O".colorize(:red)
    x_mark = "X".colorize(:green)
    board = ["0", "O", "2", "3", "X", "5", "6", "7", "8"]
    formatted_board = "|_0_|_#{o_mark}_|_2_|\n|_3_|_#{x_mark}_|_5_|\n|_6_|_7_|_8_|\n"

    expect{repl.print_board(board)}.to output("\n" + formatted_board).to_stdout
  end
 end
