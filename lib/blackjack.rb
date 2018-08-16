require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'bet'
require 'pry'

puts 'Welcome to Alberto\'s Black Jack?'
player1 = Player.new
house = House.new
system 'clear' if gets.chomp

puts 'What should I call you'
user_name = gets.chomp
=begin
After the user's input is taken in,
if it is an empy string the of the player will be the default "Player"
=end
if user_name.empty?
  player1.name
else
  player1.name = user_name
end
system 'clear' if player1.name
# binding.pry
puts "Welcome #{player1.name}"

#set the player's initial budget, only integer for now
puts 'What\'s your budget?'
trys = 0
begin
  trys += 1
  player1.budget = Integer(gets.chomp)
rescue StandardError => e
  system 'clear' if trys > 0
  puts 'budget must be a integer number, please try again'
  retry
end

trys = 0
system 'clear' if player1.budget
#set the game's number of decks, only integer for now
puts "How many decks shall we use #{player1.name}?"
begin
  trys += 1
  deck = Deck.new(Integer(gets.chomp))
rescue StandardError => e
  system 'clear' if trys > 0
  puts 'the number of decks must be a integer number, please try again'
  retry
end
# binding.pry
system 'clear' if deck
puts "Sweet, we\'ll play with #{deck.number_of_decks} decks"

#game begins
puts "let\'s start!"
system 'clear' if gets.chomp
