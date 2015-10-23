require 'board'

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

  def board
    @board.board
  end


  def start_game
    puts MESSAGES[:welcome]
    puts display_board
    puts MESSAGES[:select]

    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts display_board
      puts MESSAGES[:select] if !game_is_over(@board) && !tie(@board)
    end

    puts MESSAGES[:game_over]
  end

  def display_board
    "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp
      if valid_spot?(spot)
        @board[spot.to_i] = @hum
      else
        spot = nil

      end
    end
  end


  def eval_board
    if @board[4] == "4"
      @board[4] = @com
    else
      spot = get_best_move(@board, @com)
      @board[spot] = @com
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

  def game_is_over(board)
    check_rows(board) ||
    check_columns(board) ||
    check_diagonals(board)
  end

  def tie(board)
    board.all? { |spot| spot == "X" || spot == "O" }
  end


  private

  def check_rows(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1
  end

  def check_columns(board)
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1
  end

  def check_diagonals(board)
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def get_available_spaces(board)
    board.select {|spot| spot != "X" && spot != "O"}
  end

  def valid_spot?(spot)
    spot.match(/\d/) && (0..8).include?(spot.to_i)
  end
end


if __FILE__ == $0
  Game.new.start_game
end
