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
    invalid_spot: "Please choose a valid empty spot."
  }

  def initialize
    @board = Board.new
    @player1 = Player.new('O', true)
    @player2 = Player.new('X')
    @repl = Repl.new
  end

  def start_game
    repl.print(MESSAGES[:welcome])
    repl.print(board.display)
    repl.print(MESSAGES[:select])

    play

    repl.print(MESSAGES[:game_over])
  end

  def play
    until board.game_over? || board.tie?
      if player1.human?
        spot = get_human_spot(player1.mark)
      else
        spot = player1.choose_spot(board)
        board[spot] = player1.mark
      end


      if !board.game_over? && !board.tie?
        if player2.human?
          spot = get_human_spot(player2.mark)
        else
          spot = player2.choose_spot(board)
          board[spot] = player2.mark
        end
      end

       repl.print(board.display)
       repl.print(MESSAGES[:select]) if !board.game_over? && !board.tie?
    end

  end

  def get_human_spot(mark)
    spot = nil
    until spot
      spot = repl.read
      if board.valid_spot?(spot)
        board[spot.to_i] = mark
      else
        spot = nil
        repl.print(MESSAGES[:invalid_spot])
      end
    end
  end

  private



end

if __FILE__ == $0
  Game.new.start_game
end
