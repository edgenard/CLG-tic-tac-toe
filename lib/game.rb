require_relative 'board'
require_relative 'player'
require_relative 'repl'
require 'byebug'
class Game
  attr_reader :board, :player1, :player2, :repl

  MESSAGES = {
    welcome: "Welcome to my Tic Tac Toe game",
    select: "Please select your spot.",
    game_over: "Game over",
    invalid_spot: "Please choose a valid empty spot.",
    player2_choice: "Player 2 chose "
  }

  def initialize
    @board = Board.new
    @player1 = Player.new('O', true)
    @player2 = Player.new('X')
    @repl = Repl.new
  end

  def start_game
    repl.print(MESSAGES[:welcome])
    repl.print(format_board)
    repl.print(MESSAGES[:select])

    play

    repl.print(MESSAGES[:game_over])
  end

  def play
    until board.game_over? || board.tie?
      if player1.human?
        spot = get_human_spot
        board[spot] = player1.mark
      else
        spot = player1.choose_spot(board)
        board[spot] = player1.mark
      end

      if !board.game_over? && !board.tie?
        if player2.human?
          spot = get_human_spot
          board[spot] = player2.mark
        else
          spot = player2.choose_spot(board)
          board[spot] = player2.mark

        end
      end

      repl.clear
      repl.print(MESSAGES[:player2_choice] + spot.to_s)
      sleep 1
      repl.print(format_board)
      sleep 1
      repl.print(MESSAGES[:select]) if !board.game_over? && !board.tie?
    end
  end

  def format_board
    "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n\n"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = repl.read
      if board.valid_spot?(spot)
        return spot.to_i
      else
        spot = nil
        repl.print(MESSAGES[:invalid_spot])
      end
    end
  end

end

if __FILE__ == $0
  Game.new.start_game
end
