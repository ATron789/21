require_relative 'hand'
require_relative 'deck'

class Message
  attr_accessor :from, :to
  def initialize(from, to)
    @from = from
    @to = to
  end
end
class Email < Message
  attr_accessor :from, :to, :subject
  def initialize(from, to, subject)
    super(from, to)
    @subject = subject
  end
end

class Player < Hand
  attr_accessor :name, :budget
  def initialize(name = 'player', hand = [], budget = 0)
    super(hand)
    @name = name
    @budget = budget
  end
end
