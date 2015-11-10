#Board is responsible for the current state of the board.
class Board
  attr_reader :state, :size
  def initialize(size=3)
    @state = build_board(size)
    @size = size
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

  def rows
    rows = []
    row = []
    state.each_with_index do |val, idx|
      if row.length == size
        rows << row
        row = [val]
      elsif idx == state.length - 1
        row << val
        rows << row
      else
        row << val
      end
    end
    rows
  end


  def columns
    rows.transpose
  end

  def diagonals
    diagonals = []

    left_diagonal = []
    idx = 0
    size.times do
      left_diagonal << state[idx]
      idx = idx + size + 1
    end
    diagonals << left_diagonal

    right_diagonal = []
    idx = size - 1
    size.times do
     right_diagonal << state[idx]
     idx = idx + size - 1
    end
    diagonals << right_diagonal

    diagonals
  end

  def dup
    new_board = Board.new(size)
    new_board.state.each_index do |index|
      new_board[index] = self[index]
    end
    new_board
  end

  private

  def build_board(size)
    state = []
    (size*size).times { |idx| state << idx.to_s}
    state
  end

  def check_rows?
    rows.any? { |row| row.uniq.length == 1  }
  end




  def check_columns?
    columns.any? {|col| col.uniq.length == 1}
  end

  def check_diagonals?
    diagonals.any? {|diag| diag.uniq.length == 1}
  end



end
