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
end
