require_relative 'game_settings'
require 'pry'
class Game
  attr_accessor :player, :house, :bet
  attr_reader :deck
  def initialize(player, house, deck)
    @player = player
    @house = house
    @deck = deck
    @bet = nil
  end

  def bet_input
    puts 'What\'s your bet?'
    begin
        @bet = Integer(gets.chomp)
      rescue ArgumentError
        system 'clear'
        puts 'budget must be a integer number, please try again'
        bet_input
    end

    if bet >= player.budget
        #why this work even if player is not called as instance variable
        puts 'the bet cannot be bigger than the user budget, try again'
        bet_input
    end
  end

  def deal_the_cards
      deck.deal(player.hand.cards)
      puts "#{player.name}\'s first card is #{player.hand.cards[0].output_card}"
      deck.deal(house.hand.cards)
      puts "#{house.name}\'s first card is covered"
      deck.deal(player.hand.cards)
      puts "#{player.name}\'s second card is #{player.hand.cards[1].output_card}"
      deck.deal(house.hand.cards)
      puts "#{house.name}\'s card is #{house.hand.cards[1].output_card}"
  end
end
