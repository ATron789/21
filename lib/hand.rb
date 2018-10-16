#The hand class definse the actual holding of the cards.
#Not necessary I just wanted to experiment with class inheritance
require 'pry'

class Hand
  attr_accessor :cards
  def initialize(cards=[])
    @cards  = cards
  end
  def hand_value
    @cards.inject(0) { |sum,card| sum + card.value}
  end

  def soft_hand_value
    self.hand_value + 10 if ace_check?
  end

  def ace_check?
    @cards.any? {|card| card.rank == 'A'}
  end

  def show_cards
    @cards.each do |card|
      puts card.output_card
    end
  end

  def hand_reset
    @cards = []
  end

  def bust?
    self.best_value > 21
  end

  def doubles?
    if @cards.length == 2
      @cards.all? { |x| x.rank == @cards[0].rank}
    else
      false
    end
  end

  def best_value
    if ace_check? && self.soft_hand_value <= 21
      return self.soft_hand_value
    end
    return self.hand_value
  end

  def blackjack?
    return true if self.cards.length == 2 && self.best_value == 21
  end


end
