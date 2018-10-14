require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'bet'
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
    # binding.pry
    hit_or_stand
    house_logic
    winner
    player.hand_reset
    house.hand_reset
    if player.no_budget?
      puts "#{player.name} run has no budget left, game over"
    else
      puts "#{player.name} budget is #{player.budget}"
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
    puts
  end

  def deal_the_cards
      deck.deal(player.hands[-1].cards)
      puts "#{player.name}\'s first card is #{player.hands[-1].cards[0].output_card}"
      deck.deal(house.hand.cards)
      puts "#{house.name}\'s first card is covered"
      deck.deal(player.hands[-1].cards)
      puts "#{player.name}\'s second card is #{player.hands[-1].cards[1].output_card}"
      deck.deal(house.hand.cards)
      puts "#{house.name}\'s card is #{house.hand.cards[1].output_card}"
      puts
  end
#following method is for testing purposes
  def deal_one_card
    player.hands.each do |hand|
      # return nil if hand.bust?
      deck.deal(hand.cards)
      puts "#{player.name} got  #{hand.cards[-1].output_card}"
    end
    deck.deal(house.hand.cards)
    puts "#{house.name} got  #{house.hand.cards[-1].output_card}"
  end


  def hit_or_stand
    player.hands.each do |hand|
    if player.hands.length > 1
      puts '-----------------'
      puts "| Hand number #{player.hands.index(hand) + 1} |"
      puts '-----------------'
    end
      if hand.blackjack?
        puts 'BLACKJACK!'
        puts
        puts "#{player.name}\'s got"
        hand.show_cards
        return nil
      end
      puts "#{player.name} hand"
      puts
      hand.show_cards
      puts
      puts "#{player.name}\'s hand value is #{hand.hand_value}"
      puts
      if hand.best_value == hand.soft_hand_value
        puts "#{player.name} has a soft #{hand.soft_hand_value}"
        puts
      end
      puts "#{house.name}\'s card is #{house.hand.cards[1].output_card}\n"
      puts 'press h for hit or press s for stand'
      #implent splitting from here

      choice = gets.chomp.downcase
      case choice
      when 'h' then
        puts
        deck.deal(hand.cards)
        puts "#{player.name}\'s got #{hand.cards[-1].output_card}"
        system 'clear'
        if hand.bust?
          puts "#{player.name} busted! The House wins!"
        else
          hit_or_stand
        end
      when 's' then
        puts 'you stand'
        system 'clear'
      else
        puts 'invalid input, try again'
        hit_or_stand
      end
    end
  end
#this is so wrong
  # def splitting
  #   player.hands.each do |hand|
  #     binding.pry
  #     if  hand.cards[0].rank == hand.cards[1].rank && hand.cards.length == 2
  #       player.hands.push(Hand.new)
  #       player.hands[1].cards.push(player.hands[0].cards.slice!(0))
  #     end
  #   end
  # end



  def house_logic
    if house.hand.blackjack?
      puts "#{house.name} scored a BLACKJACK"
      puts "#{house.name}\'s got"
      house.hand.show_cards
      return nil
    end
    return nil if player.hands.all? { |hand| hand.bust?}
    if house.hand.bust?
      puts "#{house.name} busted, #{player.name} wins"
      return nil
    end
    if  house.hand.best_value < 17 || house.hand.best_value < player.best_hand
      puts "#{house.name} hand is"
      puts
      house.hand.show_cards
      puts
      puts "#{house.name} hits"
      deck.deal(house.hand.cards)
      puts "#{house.name} receives #{house.hand.cards[-1].output_card}"
      puts
      puts "#{house.name}\'s hand value is #{house.hand.hand_value}"
      puts
      if house.hand.best_value == house.hand.soft_hand_value
        puts "#{house.name} has a soft #{house.hand.soft_hand_value}"
      end
      puts
      house_logic
      return nil
    end
    if house.hand.best_value == player.best_hand
      puts "#{house.name} got"
      house.hand.show_cards
      puts
      puts "it\' a tie!"
    else
      puts "#{house.name} stands and wins"
    end
  end

  def winner
    player.hands.each do |hand|
      if player.hands.length > 1
        puts '-----------------'
        puts "| Hand number #{player.hands.index(hand) + 1} |"
        puts '-----------------'
      end
      puts "#{player.name} got"
      hand.show_cards
      puts
      puts "#{player.name}\' hand value:"
      puts hand.best_value
      puts
      puts "#{house.name} got"
      house.hand.show_cards
      puts
      puts "#{house.name}\' hand value:"
      puts house.hand.best_value
      puts
      if house.hand.bust? || (hand.best_value > house.hand.best_value && !hand.bust?)
        if hand.blackjack? && player.hands.length == 1
          player.budget += @bet * 1.5
          puts "#{player.name} wins 3:2 of the original bet"
          puts "#{player.name} wins #{@bet * 1.5}"
          next
        end
        player.budget += @bet
        puts "#{player.name} wins #{@bet}"
        next
      end
      if hand.bust? || (hand.best_value < house.hand.best_value && !house.hand.bust?)
        player.budget -= @bet
        puts "#{player.name} loses #{@bet}"
        next
      end
      if hand.best_value == house.hand.best_value
        puts "Bets are null"
        next
      end
    end
  end


end
