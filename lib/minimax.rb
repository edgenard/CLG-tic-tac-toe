require_relative "board"
require 'byebug'


class Board
  def dup
    new_board = Board.new(size)
    new_board.state.each_index do |index|
      new_board[index] = self[index]
    end
    new_board
  end
end

def other_best_move(board, mark, scoring = 1, best_score = {})
  if board.game_over?
    return scoring
  elsif board.tie?
    return 0
  end
  available_spaces = board.available_spaces
  available_spaces.each do |space|
    dup_board = board.dup
    dup_board[space.to_i] = mark
    if dup_board.game_over?
      if best_score[space.to_i]
        best_score[space.to_i] +=  scoring
      else
        best_score[space.to_i] = scoring
      end
    elsif dup_board.tie?
      #best_score[space.to_i] = 0
      if best_score[space.to_i]
        best_score[space.to_i] += 0
      else
        best_score[space.to_i] = 0
      end
    else
      if best_score[space.to_i]
        best_score[space.to_i] += get_score(dup_board, mark, scoring, best_score)
      else
        best_score[space.to_i] = get_score(dup_board, mark, scoring, best_score)
      end
    end
  end
  best_score
end

def get_score(board,mark, scoring, best_score)
  if scoring > 0
    score = other_best_move(board, other_players_mark(mark), -scoring, best_score).max_by{|k, v| v}[1]
  else
    score = other_best_move(board, other_players_mark(mark), -scoring, best_score).min_by{|k, v| v}[1]
  end

  return score
end


def other_players_mark(mark)
  mark == 'X' ? 'O' : 'X'
end
