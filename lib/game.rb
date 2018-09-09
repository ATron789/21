require_relative 'game_settings'
require 'pry'

class Game
  attr_accessor :player, :house, :bet, :player_hits
  attr_reader :deck
  def initialize(player, house, deck)
    @player = player
    @house = house
    @deck = deck
    @bet = nil
    @player_hits = 0
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
#following method is for testing purposes
  def deal_one_card
    deck.deal(player.hand.cards)
    puts "#{player.name} got  #{player.hand.cards[-1].output_card}"
    deck.deal(house.hand.cards)
    puts "#{house.name} got  #{house.hand.cards[-1].output_card}"
  end

  def hit_or_stand
    system 'clear'
    player.hand.show_cards
    puts
    puts "#{player.name}\'s hand value is #{player.hand.hand_value}"
    puts
    puts "#{house.name}\'s card is #{house.hand.cards[1].output_card}"
    puts
    puts 'press h for hit or press s for stand'

    choice = gets.chomp.downcase
    case choice
    when 'h' then
      puts
      deck.deal(player.hand.cards)
      puts "#{player.name}\'s got #{player.hand.cards[-1].output_card}"
      system 'clear'
      if player.bust?
        puts "#{player.name} busted! The House wins!"
      else
        hit_or_stand
      end
    when 's' then
      puts 'you stand'
      system 'clear'
    else
      'invalid input, try again'
      hit_or_stand
    end
  end

  def house_logic
    if player.bust?
      nil
    elsif house.bust?
      puts "#{house.name} busted, #{player.name} wins"
    elsif house.hand.hand_value == player.hand.hand_value
      puts "#{house.name} got"
      house.hand.show_cards
      puts "it\' a tie!"
    else
      if house.hand.hand_value < player.hand.hand_value || house.hand.hand_value < 17
        puts "#{house.name} hand is"
        house.hand.show_cards
        puts
        puts "#{house.name} hits"
        deck.deal(house.hand.cards)
        puts "#{house.name} receives #{house.hand.cards[-1].output_card} "
        house_logic
      # elsif house.hand.hand_value < 17
      #   deck.deal(house.hand.cards)
      #   house_logic
      else
        puts "#{house.name} stands and wins"
      end
    end
  end
  
  def winner
    case player.hand_value <=> house.hand.hand_value
    when 1 then player.budget += @bet
      puts "#{player.name} wins #{@bet}"
    when -1 then player.buget -= @bet
      puts "#{players.name} loses #{@bet}"
    end
  end
end
