require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'bet'

class GameSettings
  attr_accessor :player_name, :player_budget, :decks
  def initialize(player_name = 'foo', player_budget = 0, decks = 1)
    @player_name = player_name
    @player_budget = player_budget
    @decks = decks
  end

  def set_name(name)
    @player_name = name
  end
end
