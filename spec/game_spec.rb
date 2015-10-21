require 'rspec'
require 'game'

RSpec.describe "Game" do
  it "makes a new game" do
    game = Game.new

    expect(game).to be_kind_of(Game)
  end

end
