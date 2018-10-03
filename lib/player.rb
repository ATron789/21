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

  def self.build(inputs)
    player1 = self.new
    player1.name = inputs.p_name
    player1.budget = inputs.p_budget
    #why do I need this?
    player1
  end

  def bust?
    @hand.best_hand > 21
  end

  def no_budget?
    @budget == 0
  end
end
