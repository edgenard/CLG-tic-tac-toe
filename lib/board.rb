#Board is responsible for the current state of the board.
class Board
  attr_reader :board
  def initialize
    @board = ["1", "2", "3", "4", "5", "6", "7", "8"]
  end
end
