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

  def deal_one_card
    deck.deal(player.hand.cards)
    puts "#{player.name} got  #{player.hand.cards[-1].output_card}"
    deck.deal(house.hand.cards)
    puts "#{house.name} got  #{house.hand.cards[-1].output_card}"
  end

  def hit_or_stand
    puts 'press h for hit or press s for stand'
    choice = gets.chomp.downcase
    case choice
    when 'h' then
      deck.deal(player.hand.cards)
      puts "#{player.name} got  #{player.hand.cards[-1].output_card}"
      if player.bust?
        puts "#{player.name} busted! The House wins!"
      else
        hit_or_stand
      end
    when 's' then
      puts 'you stand'
    else
      'invalid input, try again'
      hit_or_stand
    end
  end

  def house_ai
    if house.hand.hand_value < player.hand.hand_value && house.hand.hand_value < 17
      deck.deal(house.hand.cards)
      if house.bust?
        "puts The House Busted!"
      else
        house_ai
      end
    else
      puts "#{house.name} stands"
    end
  end


end
