require 'rspec'
require 'repl'

RSpec.describe "Repl" do
  it "prints to stdout" do
    repl = Repl.new
    message = "Hello"

    expect{repl.print(message)}.to output(message).to_stdout
  end
end
