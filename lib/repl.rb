#Repl is responsible for communicating with the user via the cli
class Repl
  def print(message)
    sleep 0.5
    puts "\n" + message
  end

  def read
    user_input = gets.chomp
    user_input
  end

  def clear
    sleep 1
    system("clear")
  end

  def print_board(board)
    formatted_board = format_board(board)
    print(formatted_board)
  end

  def format_board(board)
    x_mark = "X".colorize(:green)
    o_mark = "O".colorize(:red)
    "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|\n".gsub(/[XO]/, "X" => x_mark, "O" => o_mark )
  end


end
