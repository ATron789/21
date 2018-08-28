#The hand class definse the actual holding of the cards.
#Not necessary I just wanted to experiment with class inheritance
require_relative 'deck'

class Hand
  attr_accessor :cards
  def initialize(cards=[])
    @cards  = cards
  end
  def hand_value
    @cards.inject { |x,sum| x.value + sum.value}
  end
end
