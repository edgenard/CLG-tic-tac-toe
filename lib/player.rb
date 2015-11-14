#Player is responsible for players attributes and actions
require_relative "TTT_tree"
class Player
  attr_accessor :mark, :human
  def initialize(mark:, human: false)
    @mark = mark
    @human = human
  end


  def choose_spot(board)
    TTT_Tree.new(board, mark).best_move.to_i
    # center_spot(board) || other_best_move(board, mark).max_by {|k, v| v}[0]
  end


  private
  def center_spot(board)
    center_idx = board.size/2
    spot = board.rows[center_idx][center_idx]
    return spot.to_i if spot.to_i.to_s == spot
    false
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
      score = other_best_move(board, other_players_mark, -scoring, best_score).max_by{|k, v| v}[1]
    else
      score = other_best_move(board, other_players_mark, -scoring, best_score).min_by{|k, v| v}[1]
    end

    return score
  end

  def get_best_move(board, mark, depth = 0, best_score = {})
    available_spaces = board.available_spaces
    return available_spaces.first.to_i if available_spaces.length < 2

    win = possible_move(available_spaces, board, mark)
    if win
      return win
    else
      block = possible_move(available_spaces, board, other_players_mark)
      if block
        return block
      end
    end


    n = rand(0...available_spaces.count)
    return available_spaces[n].to_i
  end

  def other_players_mark
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

end
