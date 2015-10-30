require_relative 'board'
require_relative 'player'
require_relative 'repl'
require 'byebug'
class Game
  attr_reader :board, :player1, :player2, :repl, :message


  def initialize
    @board = Board.new
    @repl = Repl.new
    @player1 = Player.new("O")
    @player2 = Player.new("X")
    @message = Message.new
  end

  def start_game
    repl.print(message.welcome)
    game_type
    choose_markers
    choose_order

    play

    repl.print(message.game_over)
  end

  def choose_markers
    repl.print(message.game_over)

    user_choice = get_user_choice(["1", "2"])
    if user_choice == "1"
      player1.mark = "X"
      player2.mark = "O"
    else
      player1.mark = "O"
      player2.mark = "X"
    end
  end

  def game_type
    repl.print(message.game_type)

    user_choice = get_user_choice(["1", "2", "3"])
    case user_choice
    when "1"
      player1.human = true
      player2.human = true
    when "3"
      player1.human = true
    end
  end

  def choose_order
    repl.print(message.choose_order)

    user_choice = get_user_choice(["1", "2"])

    if user_choice == "2"
      @player1, @player2 = @player2, @player1
    end
  end

  def play
    until board.game_over? || board.tie?
      repl.clear
      repl.print(message.colorize_board(board))
      if player1.human
        repl.print(message.select_spot)
        spot1 = get_user_choice(board.available_spaces).to_i
      else
        spot1 = player1.choose_spot(board)
      end
      repl.print(message.player_choice("1", spot1))
      board[spot1] = player1.mark
      repl.print(message.colorize_board(board))

      if !board.game_over? && !board.tie?
        if player2.human
          repl.print(message.select_spot)
          spot2 = get_user_choice(board.available_spaces).to_i
        else
          spot2 = player2.choose_spot(board)
        end
        repl.print(message.player_choice("2", spot2))
        board[spot2] = player2.mark
        repl.print(message.colorize_board(board))
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
        repl.print(message.invalid_player_choice(valid_choices))
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
