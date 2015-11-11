require_relative "board"
require_relative "player"


class TTT_Tree
  attr_reader :board, :mark

  def initialize(board, mark)
    @board = board
    @mark = mark
  end

  def children
    available_spaces = board.available_spaces
    children = available_spaces.map do |space|
      dup_board = board.dup
      dup_board[space.to_i] = mark
      TTT_Tree.new(dup_board, other_players_mark)
    end
    children
  end

  def other_players_mark
    mark == "X" ? "O": "X"
  end

end
