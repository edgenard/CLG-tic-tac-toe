require_relative "Board"
require_relative "Player"

board = Board.new
player1 = Player.new(mark:"X")
player2 = Player.new(mark:"O")

class Board
  def dup
    new_board = Board.new(size)
    new_board.state.map.with_index do |space, index|
      state[index]
  end
end

def get_best_move(board, mark, depth = 0, best_score = {})
  available_spaces = board.available_spaces
  return available_spaces.first.to_i if available_spaces.length < 2

  #Immediate win or loss
  win = possible_move(available_spaces, board, mark)
  if win
    return win
  else
    block = possible_move(available_spaces, board, other_players_mark)
    if block
      return block
    end
  end

  #Populate Hash with available moves
  available_spaces.each do  |space|

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
