require_relative 'game'
require_relative 'input_reader'
require 'pry'

puts 'Welcome to Alberto\'s Black Jack'
inputs = InputReader.new
puts 'press any key to continue'
system 'clear' if gets.chomp

inputs.set_up
player = Player.build(inputs)
house = House.new
deck = Deck.build(inputs)
new_game = Game.new(player, house, deck)
new_game.play
puts player.hand.hand_value
puts house.hand.hand_value
puts player.budget
