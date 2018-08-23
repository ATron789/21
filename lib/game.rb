require_relative 'game_settings'
require 'pry'
class Game
  attr_accessor :player, :house, :bet
  attr_reader :deck
  def initialize(player, house, deck)
    @player = player
    @house = house
    @deck = deck
    @bet = 0
  end

  def bet_input
    puts 'What\'s your bet?'

    loop do
      begin
      @bet = Integer(gets.chomp)
    rescue ArgumentError => e
        system 'clear'
        puts 'budget must be a integer number, please try again'
        retry
      end

      if @bet > player.budget
        #why this work even if player is not called as instance variable
        puts 'the bet cannot be bigger than the user budget, try again'
        redo
      else
        break
      end
    end
  end

  def deal_the_cards
    deck.deal(player.hand)
    puts "#{player.name}\'s first card is #{player.hand[0].output_card}"
    deck.deal(house.hand)
    puts "#{house.name}\'s first card is covered"
    deck.deal(player.hand)
    puts "#{player.name}\'s second card is #{player.hand[1].output_card}"
    deck.deal(house.hand)
    puts "#{house.name}\'s card is #{house.hand[1].output_card}"

    binding.pry

  end


end
