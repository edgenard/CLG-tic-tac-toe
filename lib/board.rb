#Board is responsible for the current state of the board.
class Board
  attr_reader :state
  def initialize
    @state = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
  end

  def [](idx)
    @state[idx]
  end

  def []=(idx, value)
    @state[idx] = value
  end

  def game_over?
    check_rows? || check_columns? || check_diagonals?
  end

  def tie?
    !game_over? && state.all? { |spot| spot == "X" || spot == "O" }
  end

  def available_spaces
    state.select {|space| space.to_i.to_s == space}
  end

  private

  def check_rows?
    [state[0], state[1], state[2]].uniq.length == 1 ||
    [state[3], state[4], state[5]].uniq.length == 1 ||
    [state[6], state[7], state[8]].uniq.length == 1
  end

  def check_columns?
    [state[0], state[3], state[6]].uniq.length == 1 ||
    [state[1], state[4], state[7]].uniq.length == 1 ||
    [state[2], state[5], state[8]].uniq.length == 1
  end

  def check_diagonals?
    [state[0], state[4], state[8]].uniq.length == 1 ||
    [state[2], state[4], state[6]].uniq.length == 1
  end

end
