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

def get_best_move(board, mark, depth = 0, best_score = {}, scoring = 1, minimax = true)
  message = Message.new
  available_spaces = board.available_spaces

  best_score = {}
  #Populate Hash with available moves
  available_spaces.each do  |space|
    dup_board = board.dup
    dup_board[space.to_i] = mark
    puts "Mark is #{mark}"
    puts "Space is #{space}"
    puts "Scoring is #{scoring}"
    puts message.colorize_board(dup_board.rows)
    if dup_board.game_over?
      best_score[space.to_i] ? best_score[space.to_i] += scoring : best_score[space.to_i] = scoring
      break
    elsif dup_board.tie?
      best_score[space.to_i] ? best_score[space.to_i] += 0 : best_score[space.to_i] = 0
      break
    else
      puts "recursing"
      puts "Before switch scoring is #{scoring}"
      scoring = switch_scoring(scoring)
      puts "After switch scoring is #{scoring}"
      minimax ? minimax = false : minimax = true
      best_score[space.to_i] = get_best_move(dup_board, other_players_mark(mark), depth=0, best_score, scoring, minimax)
    end
  end
  p "before getting max or min #{best_score}"
  return best_score.max_by{|k, v| v}[1] if minimax
  return best_score.min_by {|k, v| v}[1]
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
      best_score[space.to_i] = 0
    else
      best_score[space.to_i] = get_score(dup_board, mark, scoring, best_score)
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
