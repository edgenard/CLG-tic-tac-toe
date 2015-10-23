class Game

  attr_reader :board

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X"
    @hum = "O"
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @hum
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    dup_board = board.dup
    available_spaces = get_available_spaces(dup_board)
    return available_spaces.first if available_spaces.length < 2

    best_move = nil  
    available_spaces.each do |as|
      dup_board[as.to_i] = next_player
      if game_is_over(dup_board)
        best_move = as.to_i
        return best_move
      else
        dup_board[as.to_i] = @hum
        if game_is_over(dup_board)
          best_move = as.to_i
          return best_move
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

end


if __FILE__ == $0
  Game.new.start_game
end
