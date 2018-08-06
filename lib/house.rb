require_relative 'hand'
#this class defines the house, inheriting the hand instance from the Hand class.
#differently from the Player doesn't have an initial budget

class House < Hand
  attr_accessor :name
  def initialize(name = 'House', hand = [])
    super(hand)
    @name = name
  end
end
