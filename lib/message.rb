#Responsible for forming the messages that go out to the user.
require 'colorize'
class Message

  def welcome
    "Welcome to my Tic Tac Toe game!"
  end

  def select_spot
    "Please select your spot."
  end

  def game_over
    "Game over."
  end

  def player_choice(player, choice)
    "Player #{player} chose #{choice}"
  end

  def invalid_player_choice(valid_choices)
    choices_string = valid_choices.join(", ").sub(/(.*)(,)/, "\\1 or")
    "Please choose #{choices_string}"
  end

  def game_type
    "Please choose the type of game you would like to play. \nChoose 1 for Human vs Human. Choose 2 for Computer vs Computer. Choose 3 for Human vs Computer"
  end

  def choose_marker
    "Please choose the marker for Player 1. \n Choose 1 for X. \n Choose 2 for O."
  end

  def choose_order
    "Please choose which player goes first. \nChoose 1 for Player 1. \nChoose 2 for Player 2"
  end

  def format_board(board)
    "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end

  def colorize_markers(message)
    x_mark = "X".colorize(:green)
    o_mark = "O".colorize(:red)
    message.gsub(/[XO]/, "X" => x_mark, "O" => o_mark )
  end

  def colorize_board(board)
    colorize_markers(format_board(board))
  end
end
