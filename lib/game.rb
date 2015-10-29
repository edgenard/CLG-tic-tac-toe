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
    player1_choice: "Player 1 chose ",
    player2_choice: "Player 2 chose ",
    game_type: "Please choose the type of game you would like to play\nChoose 1 for Human vs Human. Choose 2 for Computer vs Computer. Choose 3 for Human vs Computer",
    invalid_player_choice: "Please choose 1, 2 or 3",
    choose_marker: "Please choose the marker for Player 1 \n Choose 1 for X \n Choose 2 for O"
  }

  def initialize
    @board = Board.new
    @repl = Repl.new
    @player1 = Player.new("O")
    @player2 = Player.new("X")
  end

  def start_game
    repl.print(MESSAGES[:welcome])
    game_type
    choose_markers

    play

    repl.print(MESSAGES[:game_over])
  end

  def choose_markers
    repl.print(MESSAGES[:choose_marker])

    user_choice = nil
    until user_choice do
      user_choice = get_user_choice
      if valid_choice?(user_choice, ["1", "2"])
        setup_markers(user_choice)
      else
        user_choice = nil
        repl.print("Please choose 1 or 2")
      end
    end

  end

  def game_type
    repl.print(MESSAGES[:game_type])

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
      if player1.human
        repl.print(MESSAGES[:select])
        spot1 = get_human_spot
      else
        spot1 = player1.choose_spot(board)
      end
      repl.print(MESSAGES[:player1_choice] + spot1.to_s)
      board[spot1] = player1.mark
      repl.print_board(board)

      if !board.game_over? && !board.tie?
        if player2.human
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
      spot = get_user_choice
      if valid_choice?(spot, board.available_spaces)
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
      player1.human = true
      player2.human = true
    when "3"
      player1.human = true
    end
  end

  def setup_markers(user_choice)
    if user_choice == "1"
      player1.mark = "X"
      player2.mark = "O"
    end
  end

  def valid_choice?(input, possible_choices)
    possible_choices.include?(input)
  end

end

if __FILE__ == $0
  Game.new.start_game
end
