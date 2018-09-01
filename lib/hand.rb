#The hand class definse the actual holding of the cards.
#Not necessary I just wanted to experiment with class inheritance
require_relative 'deck'
require 'pry'

class Hand
  attr_accessor :cards
  def initialize(cards=[])
    @cards  = cards
  end
  def hand_value
    binding.pry
    @cards.inject { |card,sum| card.value + sum.value}
  end

  def ace_check
    @cards.each do |card|
      if card.rank == 'A'
        return true
      else
        return false
      end
    end
  end
end
