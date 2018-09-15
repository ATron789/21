require_relative 'game'
require 'pry'

puts 'Welcome to Alberto\'s Black Jack'
gamesets = GameSettings.new
puts 'press any key to continue'
system 'clear' if gets.chomp

gamesets.set_up
player = Player.build(gamesets)
house = House.new
deck = Deck.build(gamesets)
new_game = Game.new(player, house, deck)
new_game.play
puts player.hand.hand_value
puts house.hand.hand_value
puts player.budget
