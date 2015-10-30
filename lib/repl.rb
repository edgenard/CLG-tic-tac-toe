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
end
