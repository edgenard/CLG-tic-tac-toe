#Repl is responsible for communicating with the user via the cli
class Repl

  def print(message)
    puts message
  end

  def read
    user_input = gets.chomp
    user_input
  end

  def print_board(board)
    puts board.display
  end


end
