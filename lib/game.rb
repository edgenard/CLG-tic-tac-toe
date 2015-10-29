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
    player1_choice: "Player 1 chose ",
    player2_choice: "Player 2 chose ",
    invalid_player_choice: "Please choose ",
    game_type: "Please choose the type of game you would like to play\nChoose 1 for Human vs Human. Choose 2 for Computer vs Computer. Choose 3 for Human vs Computer",
    choose_marker: "Please choose the marker for Player 1 \n Choose 1 for X. \n Choose 2 for O.",
    choose_order:"Please choose which player goes first. \nChoose 1 for Player 1. \nChoose 2 for Player 2"
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

    user_choice = get_user_choice(["1", "2"])
    if user_choice == "1"
      player1.mark = "X"
      player2.mark = "O"
    end
  end

  def game_type
    repl.print(MESSAGES[:game_type])

    user_choice = get_user_choice(["1", "2", "3"])
    case user_choice
    when "1"
      player1.human = true
      player2.human = true
    when "3"
      player1.human = true
    end
  end

  def play
    until board.game_over? || board.tie?
      repl.clear
      repl.print_board(board)
      if player1.human
        repl.print(MESSAGES[:select])
        spot1 = get_user_choice(board.available_spaces).to_i
      else
        spot1 = player1.choose_spot(board)
      end
      repl.print(MESSAGES[:player1_choice] + spot1.to_s)
      board[spot1] = player1.mark
      repl.print_board(board)

      if !board.game_over? && !board.tie?
        if player2.human
          repl.print(MESSAGES[:select])
          spot2 = get_user_choice(board.available_spaces).to_i
        else
          spot2 = player2.choose_spot(board)
        end
        repl.print(MESSAGES[:player2_choice] + spot2.to_s)
        board[spot2] = player2.mark
        repl.print_board(board)
      end
    end
  end


  def get_user_choice(valid_choices)
    user_choice = nil
    until user_choice
      user_choice = repl.read
      if valid_choice?(user_choice, valid_choices)
        return user_choice
      else
        user_choice = nil
        choices_string = valid_choices.join(", ").sub(/(.*)(,)/, "\\1 or")
        repl.print(MESSAGES[:invalid_player_choice] + choices_string)
      end
    end

  end

  private

  def valid_choice?(input, possible_choices)
    possible_choices.include?(input)
  end

end

if __FILE__ == $0
  Game.new.start_game
end
