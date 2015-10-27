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


end
