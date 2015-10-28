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
    player2_choice: "Player 2 chose ",
    pick_players: "Please choose the type of game you would like to play\nChoose 1 for Human vs Human. Choose 2 for Computer vs Computer. Choose 3 for Human vs Computer",
    invalid_player_choice: "Please choose 1, 2 or 3"
  }

  def initialize
    @board = Board.new
    @repl = Repl.new
  end

  def start_game
    repl.print(MESSAGES[:welcome])
    pick_players

    play

    repl.print(MESSAGES[:game_over])
  end

  def pick_players
    repl.print(MESSAGES[:pick_players])

    user_choice = nil
    until user_choice do
      user_choice = get_user_choice
      if valid_choice?(user_choice, ["1", "2", "3"])
        setup_players(user_choice)
      else
        user_choice = nil
        repl.print(MESSAGES[:invalid_player_choice])
      end
    end
  end

  def play
    until board.game_over? || board.tie?
      repl.clear
      repl.print_board(board)
      if player1.human?
        repl.print(MESSAGES[:select])
        spot1 = get_human_spot
      else
        spot1 = player1.choose_spot(board)
      end
        repl.print("Player 1 chose " + spot1.to_s)
        board[spot1] = player1.mark
        repl.print_board(board)

      if !board.game_over? && !board.tie?
        if player2.human?
          repl.print(MESSAGES[:select])
          spot2 = get_human_spot
        else
          spot2 = player2.choose_spot(board)
        end
        repl.print(MESSAGES[:player2_choice] + spot2.to_s)
        board[spot2] = player2.mark
        repl.print_board(board)
      end
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

  private

  def get_user_choice
    repl.read
  end

  def setup_players(user_choice)
    case user_choice
    when "1"
      @player1 = Player.new("O", true)
      @player2 = Player.new("X", true)
    when "2"
      @player1 = Player.new("O")
      @player2 = Player.new("X")
    when "3"
      @player1 = Player.new("O", true)
      @player2 = Player.new("X")
    end
  end

  def valid_choice?(input, possible_choices)
    possible_choices.include?(input)
  end

end

if __FILE__ == $0
  Game.new.start_game
end
