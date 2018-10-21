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
    # player.hands[0].cards.push(Card.new(rank: 10, suit: 'H'))
    # player.hands[0].cards.push(Card.new(rank: 10, suit: 'H'))
    # house.hand.cards.push(Card.new(rank: 9, suit: 'H'))
    # house.hand.cards.push(Card.new(rank: 8, suit: 'H'))
    binding.pry
    splitting
    hit_or_stand
    house_logic
    winner
    player.hand_reset
    house.hand_reset
    if player.no_budget?
      puts "#{player.name} run has no budget left, game over"
      return nil
    end
    puts "#{player.name} budget is #{player.budget}"
    puts "new game, let\'s go. Press any key to continue"
    system 'clear' if gets.chomp
    play
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

  def splitting
    player.hands.each do |hand|
      if hand.doubles?
        puts 'you have 2 cards with the same rank'
        puts 'do you want to split your hand'
        puts
        puts '----------------'
        hand.show_cards
        puts '----------------'
        puts
        puts 'press y to split, press n to keep your hand'
        begin
          choice = gets.chomp.downcase
          # binding.pry
          case choice
          when 'y' then
            player.hands.push(Hand.new)
            player.hands[-1].cards.push(hand.cards.shift)
            [hand, player.hands[-1]].each { |h| deck.deal(h.cards)}
            player.hands.each  do |h|
              puts '-----------------'
              puts "| Hand number #{player.hands.index(h) + 1} |"
              puts '-----------------'
              h.show_cards
              next
            end
            # deck.deal(hand.cards)
            # deck.deal(player.hands[-1].cards)
            next
          when 'n' then
            next
          else
            puts 'press y to split, press n to keep your hand'
            raise ArgumentError
          end
        rescue
          retry
        end
      end
    end
    puts 'press any key to continue'
    system 'clear' if gets.chomp

  end


  def hit_or_stand
    puts "\n--------------------------"
    puts "#{player.name}\'s turn"
    puts "--------------------------\n"
    player.hands.each do |hand|
    if player.hands.length > 1
      puts '-----------------'
      puts "| Hand number #{player.hands.index(hand) + 1} |"
      puts '-----------------'
    end
      if hand.blackjack? && player.hands.length == 1
        puts 'BLACKJACK!'
        puts
        puts "#{player.name}\'s got"
        hand.show_cards
        puts
        next
      end
      puts
      #implent splitting from here
      begin
        puts "#{player.name}\'s hand"
        puts
        hand.show_cards
        puts
        puts "#{player.name}\'s hand value is #{hand.hand_value}\n"
        if hand.best_value == hand.soft_hand_value
          puts
          puts "#{player.name} has a soft #{hand.soft_hand_value}"
          puts
        end
        puts
        puts "#{house.name}\'s card is #{house.hand.cards[1].output_card}\n"
        puts
        puts 'press h for hit or press s for stand'
        choice = gets.chomp.downcase
        case choice
        when 'h' then
          puts
          deck.deal(hand.cards)
          puts "#{player.name}\'s got #{hand.cards[-1].output_card}"
          puts
          if hand.bust?
            puts "busted!\n"
            next
          end
          raise
        when 's' then
          puts 'you stand'
          next
        else
          puts 'invalid input, try again'
          raise
        end
      rescue
        retry
      end
    end
    puts "#{house.name}\'s turn"
  end



  def house_logic
    puts 'press any key to continue'
    system 'clear' if gets.chomp
    # puts 'I am in house'
    puts
    if house.hand.blackjack?
      puts "#{house.name} scored a BLACKJACK"
      puts "#{house.name}\'s got"
      house.hand.show_cards
      puts
      puts 'press any key to continue'
      system 'clear' if gets.chomp
      puts
      return nil
    end
    return nil if player.hands.all? { |hand| hand.bust?}
    if house.hand.bust?
      puts "#{house.name} busted, #{player.name} wins"
      puts 'press any key to continue'
      system 'clear' if gets.chomp
      puts
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
    # puts "I am in winner"
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
          puts 'press any key to continue'
          gets.chomp
          puts
          next
        end
        player.budget += @bet
        puts "#{player.name} wins #{@bet}"
        puts 'press any key to continue'
        gets.chomp
        puts
        next
      end
      if hand.bust? || (hand.best_value < house.hand.best_value && !house.hand.bust?)
        player.budget -= @bet
        puts "#{player.name} loses #{@bet}"
        puts 'press any key to continue'
        gets.chomp
        puts
        next
      end
      if hand.best_value == house.hand.best_value
        puts "Bets are null"
        puts 'press any key to continue'
        gets.chomp
        puts
        next
      end
    end
  end


end
