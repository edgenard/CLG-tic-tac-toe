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


 end
