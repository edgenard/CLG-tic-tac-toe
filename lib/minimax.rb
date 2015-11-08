require_relative "board"
require_relative "player"
require_relative "message"

board = Board.new
player1 = Player.new(mark:"X")
player2 = Player.new(mark:"O")


class Board
  def dup
    new_board = Board.new(size)
    new_board.state.each_index do |index|
      new_board[index] = self[index]
    end
    new_board
  end
end

def get_best_move(board, mark, depth = 0, best_score = {}, scoring=1)
  message = Message.new
  available_spaces = board.available_spaces


  #Populate Hash with available moves
  available_spaces.each do  |space|
    dup_board = board.dup
    dup_board[space.to_i] = mark
    puts "Mark is #{mark}"
    puts "Scoring is #{scoring}"
    puts message.colorize_board(dup_board.rows)
    p best_score
    if dup_board.game_over?
      best_score[space.to_i] ? best_score[space.to_i] += scoring : best_score[space.to_i] = scoring
    elsif dup_board.tie?
      best_score[space.to_i] ? best_score[space.to_i] += 0 : best_score[space.to_i] = 0
    else
      puts "recursing"

      scoring = switch_scoring(scoring)
      best_score[space.to_i] = get_best_move(dup_board, other_players_mark(mark), depth=0, best_score, scoring)
    end
  end
  p best_score
  return best_score.min_by {|k, v| v}[0]
end

def switch_scoring(scoring)
  scoring == 1 ? -1 : 1
end

def other_players_mark(mark)
  mark == 'X' ? 'O' : 'X'
end

def possible_move(spaces, board, mark)
  spaces.each do |space|
    board[space.to_i] = mark
    if board.game_over?
      board[space.to_i] = space
      return space.to_i
    else
      board[space.to_i] = space
    end
  end

  return nil
end


# def score(board, mark, space)
#   board[space.to_i] = mark
#   if board.game_over?
#     board[space.to_i] = space
#     return 1
#   elsif board.tie?
#     board[space.to_i] = space
#     return 0
#   end
#
#   board[space.to_i] = other_players_mark
#   if board.game_over?
#     board[space.to_i] = space
#     return -1
#   elsif board.tie?
#     board[space.to_i] = space
#     return 0
#   end
#   board[space.to_i] = space
#
#   return nil
# end
