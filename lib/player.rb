require_relative 'hand'
#this class defines the actual player, inheriting the hand instance from the Hand class.
#it has also a name and budget instance
class Player < Hand
  attr_accessor :name, :budget
  def initialize(name = 'Player', hand = [], budget = 0)
    super(hand)
    @name = name
    @budget = budget
  end
end
