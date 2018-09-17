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

    @cards.inject(0) { |sum,card| sum + card.value}
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
  def show_cards
    @cards.each do |card|
      puts card.output_card
    end
  end
  def hand_reset
    @cards = []
  end
end
