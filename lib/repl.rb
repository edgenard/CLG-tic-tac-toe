#Repl is responsible for communicating with the user via the cli
class Repl


  def print(message)
    puts "\n" + message
  end

  def read
    user_input = gets.chomp
    user_input
  end

  def clear
    system("clear")
  end

  def print_board(board)
    formatted_board = format_board(board)
    print(formatted_board)
  end

  def format_board(board)
    "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n"
  end


end
