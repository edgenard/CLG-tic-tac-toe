require_relative "board"
require_relative "player"
require 'byebug'


class TTT_Tree
  attr_reader :board, :mark, :previous_move

  def initialize(board, mark, previous_move = nil)
    @board = board
    @mark = mark
    @previous_move = previous_move
  end

  def children
    available_spaces = board.available_spaces
    children = available_spaces.map do |space|
      dup_board = board.dup
      dup_board[space.to_i] = mark
      TTT_Tree.new(dup_board, other_players_mark, space)
    end
    children
  end

  def other_players_mark
    mark == "X" ? "O": "X"
  end

  def best_move
    if board.game_over?
      return true
    elsif board.tie?
      return true
    end
    queue = children
    move = nil
    move_hash = {}
    until queue.empty?
      child = queue.shift
      if child.best_move
        
        move = child.previous_move
        break
      else
        queue = queue + child.children
      end
    end
    move
  end


end
