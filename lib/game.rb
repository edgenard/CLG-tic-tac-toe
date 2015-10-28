require_relative 'board'
require_relative 'player'
require_relative 'repl'
require 'colorize'
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
    repl.print_board(board)
    repl.print(MESSAGES[:select])

    play

    repl.print(MESSAGES[:game_over])
  end

  def play
    until board.game_over? || board.tie?
      if player1.human?
        spot1 = get_human_spot
      else
        spot1 = player1.choose_spot(board)
      end
        board[spot1] = player1.mark

      if !board.game_over? && !board.tie?
        if player2.human?
          spot2 = get_human_spot
        else
          spot2 = player2.choose_spot(board)
        end
        board[spot2] = player2.mark
      end

      repl.clear
      repl.print(MESSAGES[:player2_choice] + spot2.to_s)
      repl.print_board(board)
      repl.print(MESSAGES[:select]) if !board.game_over? && !board.tie?
    end
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
