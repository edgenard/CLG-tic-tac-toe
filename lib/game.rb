require_relative 'board'

class Game

  attr_reader :board

  MESSAGES = {
    welcome: "Welcome to my Tic Tac Toe game",
    select: "Please select your spot.",
    game_over: "Game over",
    invalid_spot: "Please choose a valid empty spot."
  }

  def initialize
    @board = Board.new
    @com = "X"
    @hum = "O"
  end

  def state
    board.state
  end


  def start_game
    puts MESSAGES[:welcome]
    puts board.display
    puts MESSAGES[:select]

    until board.game_over? || board.tie?
      get_human_spot
      if !board.game_over? && !board.tie?
        eval_board
      end
      puts board.display
      puts MESSAGES[:select] if !board.game_over? && !board.tie?
    end

    puts MESSAGES[:game_over]
  end


  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp
      if valid_spot?(spot)
        board[spot.to_i] = @hum
      else
        spot = nil
        puts MESSAGES[:invalid_spot]
      end
    end
  end


  def eval_board
    if board[4] == "4"
      board[4] = @com
    else
      spot = get_best_move(state, @com)
      board[spot] = @com
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    dup_board = board.dup
    available_spaces = get_available_spaces(dup_board)
    return available_spaces.first.to_i if available_spaces.length < 2


    available_spaces.each do |as|
      dup_board[as.to_i] = next_player
      if game_is_over(dup_board)
        return  as.to_i
      else
        dup_board[as.to_i] = @hum
        if game_is_over(dup_board)
          return as.to_i
        else
          dup_board[as.to_i] = as
        end
      end
    end

    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i

  end




  private

  def valid_spot?(spot)
    spot.match(/\d/) && (0..8).include?(spot.to_i)
  end
end


if __FILE__ == $0
  Game.new.start_game
end
