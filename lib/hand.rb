#The hand class definse the actual holding of the cards.
#Not necessary I just wanted to experiment with class inheritance
class Hand
  attr_accessor :hand
  def initialize(hand=[])
    @hand = hand
  end
end
