require_relative 'hand'
#this class defines the house, inheriting the hand instance from the Hand class.
#differently from the Player doesn't have an initial budget

class House
  attr_accessor :name, :hand
  def initialize(name: 'The House')
    @hand = Hand.new
    @name = name
  end

  def bust?
    @hand.best_hand > 21
  end
end
