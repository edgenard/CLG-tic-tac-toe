#Player is responsible for players attributes and actions
class Player
  attr_reader :mark
  def initialize(mark, human=false)
    @mark = mark
    @human = human
  end

  def human?
    @human
  end

  def choose_spot(board)
    return 4 if board[4] == '4'
    get_best_move(board, mark)
  end


  private

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


    n = rand(0..available_spaces.count)
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