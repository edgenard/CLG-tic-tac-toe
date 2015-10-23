#Player is responsible for players attributes and actions
class Player
  attr_reader :mark
  def initialize(mark, human=false)
    @mark = mark
    @human = human
  end

  def human?
    @human
  end
end
