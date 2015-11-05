require 'rspec'
require 'input_output'

RSpec.describe "InputOutput" do
  let(:input_output) {  InputOutput.new}
  before(:each) do
    allow(input_output).to receive(:sleep).and_return(nil)
  end
  it "prints to stdout" do
    message = "Hello"

    expect{input_output.print(message)}.to output("\n" + message + "\n").to_stdout
  end

  it "slows down the printing of messages" do
    allow(input_output).to receive(:puts).and_return(nil)

    input_output.print("Hello")

    expect(input_output).to have_received(:sleep)
  end

  it "reads from stdin" do
    message = "Hello"
    allow(input_output).to receive(:gets).and_return(message)

    result = input_output.read

    expect(result).to eq(message)
  end

  it "clears the console with 1 second delay" do
    system = double("system")
    allow(input_output).to receive(:system)

    input_output.clear

    expect(input_output).to have_received(:sleep).with(1)
    expect(input_output).to have_received(:system).with("clear")
  end


 end
