require_relative 'board'
require_relative 'player'
require_relative 'input_output'
require_relative 'message'
class Game
  attr_reader :board, :player1, :player2, :input_output, :message


  def initialize
    @board = Board.new
    @input_output = InputOutput.new
    @player1 = Player.new(mark:"O")
    @player2 = Player.new(mark:"X")
    @message = Message.new
  end

  def start_game
    input_output.print(message.welcome)
    game_type
    choose_markers
    choose_order

    play

    input_output.print(message.game_over)
  end

  def choose_markers
    input_output.print(message.choose_marker)

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
    input_output.print(message.game_type)

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
    input_output.print(message.choose_order)

    user_choice = get_user_choice(["1", "2"])

    if user_choice == "2"
      @player1, @player2 = @player2, @player1
    end
  end

  def choose_board_size
    input_output.print(message.choose_board_size)
    user_choice = get_user_choice(["1", "2", "3"])
    case user_choice
    when "2"
      @board = Board.new(4)
    when "3"
      @board = Board.new(5)
    end
  end

  def play
    until board.game_over? || board.tie?
      input_output.clear
      input_output.print(message.colorize_board(board))
      spot1 = get_player_spot(player1)
      input_output.print(message.player_choice(player:"1", choice:spot1))
      board[spot1] = player1.mark
      input_output.print(message.colorize_board(board))

      if !board.game_over? && !board.tie?
        spot2 = get_player_spot(player2)
        input_output.print(message.player_choice(player:"2", choice:spot2))
        board[spot2] = player2.mark
        input_output.print(message.colorize_board(board))
      end
    end
  end

  def get_player_spot(player)
    if player.human
      input_output.print(message.select_spot)
      spot = get_user_choice(board.available_spaces).to_i
    else
      spot = player.choose_spot(board)
    end
    spot
  end

  def get_user_choice(valid_choices)
    user_choice = nil
    until user_choice
      user_choice = input_output.read
      if valid_choice?(user_choice, valid_choices)
        return user_choice
      else
        user_choice = nil
        input_output.print(message.invalid_player_choice(valid_choices))
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
