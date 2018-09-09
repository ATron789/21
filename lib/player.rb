require_relative 'hand'
#this class defines the actual player, inheriting the hand instance from the Hand class.
#it has also a name and budget instance
class Player
  attr_accessor :name, :budget, :hand
  def initialize(name: 'Player', budget: 0)
    @name = name
    @budget = budget
    @hand  = Hand.new
  end

  def self.build(gamesets)
    player1 = self.new
    player1.name = gamesets.player_name
    player1.budget = gamesets.player_budget
    #why do I need this?
    player1
  end
  def bust?
    @hand.hand_value > 21
  end
end
