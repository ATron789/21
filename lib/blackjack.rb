require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'bet'
require 'pry'

puts 'Welcome to Alberto\'s Black Jack?'
player1 = Player.new
house = House.new

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
binding.pry
puts "Welcome #{player1.name}"

#set the player's initial budget, only integer for now
puts 'What\'s your budget?'
begin
  player1.budget = Integer(gets.chomp)
rescue StandardError => e
  puts 'budget must be a integer number, please try again'
  retry
end

#set the game's number of decks, only integer for now
puts "How many decks shall we use #{player1.name}?"
begin
  deck = Deck.new(Integer(gets.chomp))
rescue StandardError => e
  puts 'the number of decks must be a integer number, please try again'
  retry
end
binding.pry
puts "Sweet, we\'ll play with #{deck.number_of_decks} decks"

#game begins
puts "let\'s start!"
