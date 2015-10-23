#Board is responsible for the current state of the board.
class Board
  attr_reader :board
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def display
    "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def [](idx)
    @board[idx]
  end

  def []=(idx, value)
    @board[idx] = value
  end

  def game_over?
    check_rows? || check_columns? || check_diagonals?
  end

  def tie?
    !game_over? && board.all? { |spot| spot == "X" || spot == "O" }
  end

  private

  def check_rows?
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1
  end

  def check_columns?
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1
  end

  def check_diagonals?
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

end
