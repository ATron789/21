require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'game_settings'
require_relative 'bet'
require 'pry'

puts 'Welcome to Alberto\'s Black Jack'
gamesets = GameSettings.new
system 'clear' if gets.chomp

gamesets.name_input
=begin
After the user's input is taken in,
if it is an empy string the of the player will be the default "Player"
=end

# system 'clear'
puts "Welcome #{gamesets.player_name}"
# binding.pry


#set the player's initial budget, only integer for now
gamesets.budget_input
player = Player.build(gamesets)

system 'clear'

#set the game's number of decks, only integer for now
gamesets.decks_input

deck = Deck.build(gamesets)
# binding.pry

system 'clear'
puts "Sweet, we\'ll play with #{deck.number_of_decks} decks"

#game begins
puts "let\'s start!"
system 'clear' if gets.chomp
