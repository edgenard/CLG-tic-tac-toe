require_relative "board"
require_relative "player"
require_relative "message"
require 'byebug'


class TTT_Tree
  attr_reader :board, :mark, :previous_move, :depth

  def initialize(board, mark, previous_move = nil, depth = 0)
    @board = board
    @mark = mark
    @previous_move = previous_move
    @depth = depth
  end

  def children
    available_spaces = board.available_spaces
    @depth = @depth + 1
    children = available_spaces.map do |space|
      dup_board = board.dup
      dup_board[space.to_i] = mark
      TTT_Tree.new(dup_board, other_players_mark, space, @depth)
    end
    children
  end

  def other_players_mark
    mark == "X" ? "O": "X"
  end

  def best_move
    winning_moves =children.select {|child| child.winning_move?(mark)}
    if !winning_moves.empty?
      return winning_moves.reduce { |closest,move| closest.depth > move.depth ? move : closest }.previous_move
    end
    non_losing_moves = children.select{|child| !child.losing_move?(mark)}
    return non_losing_moves.reduce{|closest, move| closest.depth > move.depth ? move : closest}.previous_move
  end

  def winning_move?(playing)
    if board.tie?
      return false
    end
    if board.game_over?
      return other_players_mark == playing
    elsif mark == playing
      children.any? {|child| child.winning_move?(playing)}
    else
      children.all? {|child| child.winning_move?(playing)}
    end
  end

  def losing_move?(playing)
    if board.tie?
      return false
    end
    if board.game_over?
      return other_players_mark != playing
    elsif mark == playing
      return children.all? {|child| child.losing_move?(playing)}
    else
      return children.any? { |child| child.losing_move?(playing)}
    end
  end

end
