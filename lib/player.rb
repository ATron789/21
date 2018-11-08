require_relative 'hand'

#this class defines the actual player, inheriting the hand instance from the Hand class.
#it has also a name and budget instance
class Player
  attr_accessor :name, :budget, :hands
  def initialize(name: 'Player', budget: 0)
    @name = name
    @budget = budget
    @hands  = [Hand.new]
  end

  def self.build(inputs)
    player1 = self.new
    player1.name = inputs.p_name
    player1.budget = inputs.p_budget
    #why do I need this?
    player1
  end

  def blackjack?
    @hands.length == 1 && @hands[0].blackjack?
  end

  def no_budget?
    @budget == 0
  end

  def hand_reset
    @hands = [Hand.new]
  end

  def best_hand
    not_busted_hands = @hands.select{ |hand| !hand.bust? }
    not_busted_hands.map! { |hand| hand.best_value }
    not_busted_hands.max
  end
end
