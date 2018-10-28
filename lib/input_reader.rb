require_relative 'player'
require_relative 'screencleaner'


class InputReader

  attr_accessor :p_name, :p_budget, :n_deck, :bet_in

  def initialize(p_name: 'Player', p_budget: 0, n_deck: 1, bet_in: 1)
    @p_name = p_name
    @p_budget = p_budget
    @n_deck = n_deck
    @bet_in = bet_in
  end

  def set_up
    name_input
    budget_input
    decks_input
    puts "let'\s start!"
    puts "press any key to continue"
    Screen.cleaner
  end

  def name_input
    puts 'What should I call you'
    user_name = gets.chomp
    @p_name = user_name unless user_name.empty?
    puts
    puts "Welcome #{@p_name}"
    puts
  end

  def budget_input
    puts 'What\'s your budget?'
    puts "You can choose between 5000, 10000, 20000 or 50000"
    puts "Please choose one of the above options"
    begin
      @p_budget = Integer(gets.chomp)
      raise ArgumentError unless [5000, 10000, 20000, 50000].include? @p_budget
    rescue ArgumentError
      system 'clear'
      puts 'budget must be one of the following options:'
      puts '5000, 10000, 20000 or 50000'
      puts 'please try again'
      retry
    end
    puts
    puts "Your budget is #{@p_budget}"
    puts
  end

  def decks_input
    puts "How many decks shall we use #{@p_name}?"
    puts "We can play with: 1, 2, 4, 6 or 8 decks "
    puts "Please choose one of the above options"
    begin
      decks_input = gets.chomp
      @n_deck = Integer(decks_input)
      raise ArgumentError unless [1, 2, 4, 6, 8].include? Integer(decks_input)
    rescue ArgumentError
      system 'clear'
      puts 'the number of decks must be a integer number and one of the following options:'
      puts "1, 2, 4, 6 or 8"
      retry
    end
    puts
    puts "Ok #{@p_name} we\'ll play with #{@n_deck} decks"
    puts
  end

  def bet_input(player)
    puts 'What\'s your bet?'
    begin
        @bet_in = Integer(gets.chomp)
        raise ArgumentError unless Integer(@bet_in) != 0
      rescue ArgumentError
        system 'clear'
        puts 'bet must be an integer number greater than 0'
        retry
    end

    if bet_in > player.budget
        #why this work even if player is not called as instance variable
        puts 'the bet cannot be bigger than the user budget, try again'
        bet_input(player)
    end
  end

end
