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

  def play
    bet_input
    deal_the_cards
    hit_or_stand
    house_logic
    winner
    player.hand.hand_reset
    house.hand.hand_reset
    if player.no_budget?
      puts "#{player.name} run has no budget left, game over"
    else
      puts "new game, let\'s go. Press any key to continue"
      system 'clear' if gets.chomp
      play
    end
  end

  def bet_input
    puts 'What\'s your bet?'
    begin
        @bet = Integer(gets.chomp)
        raise ArgumentError unless Integer(@bet) != 0
      rescue ArgumentError
        system 'clear'
        puts 'bet must be an integer number greater than 0'
        retry
    end

    if bet > player.budget
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
      puts
      puts "it\' a tie!"
    else
      if house.hand.hand_value < player.hand.hand_value || house.hand.hand_value < 17
        puts "#{house.name} hand is"
        house.hand.show_cards
        puts
        puts "#{house.name} hits"
        deck.deal(house.hand.cards)
        puts "#{house.name} receives #{house.hand.cards[-1].output_card}"
        puts
        house_logic
      else
        puts "#{house.name} stands and wins"
      end
    end
  end

  def winner
    puts "#{player.name} got"
    player.hand.show_cards
    puts
    puts "#{player.name}\' hand value:"
    puts player.hand.hand_value
    puts
    puts "#{house.name} got"
    house.hand.show_cards
    puts
    puts "#{house.name}\' hand value:"
    puts house.hand.hand_value
    puts
    if house.bust?
      player.budget += @bet
      puts "#{player.name} wins #{@bet}"
    elsif player.bust?
      player.budget -= @bet
      puts "#{player.name} loses #{@bet}"
    elsif player.hand.hand_value > house.hand.hand_value
      player.budget += @bet
      puts "#{player.name} wins #{@bet}"
    elsif player.hand.hand_value < house.hand.hand_value
      player.budget -= @bet
      puts "#{player.name} loses #{@bet}"
    elsif player.hand.hand_value == house.hand.hand_value
      puts "Bets are null"
    end
  end


end
