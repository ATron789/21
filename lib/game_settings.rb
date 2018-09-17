require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'house'
require_relative 'bet'

class GameSettings
  attr_accessor :player_name, :player_budget, :decks
  def initialize(player_name = 'Player', player_budget = 0, decks = 1)
    @player_name = player_name
    @player_budget = player_budget
    @decks = decks
  end

  def set_up
    # binding.pry
    name_input
    budget_input
    decks_input
    puts "let\'s start!"
    puts 'press any key to continue'
    system 'clear' if gets.chomp
  end
#I will implement this with the via the InputReader Class
  # def set_up(inputs)
  #   @player_name = inputs.name
  #   @player_budget = inputs.budget
  #   @decks = inputs.decks
  # end

  def name_input
    puts 'What should I call you'
    user_name = gets.chomp
    @player_name = user_name unless user_name.empty?
    puts
    puts "Welcome #{@player_name}"
    puts
  end
  # def budget_input
  #     puts 'What\'s your budget?'
  #     begin
  #       @player_budget = Integer(gets.chomp)
  #     rescue ArgumentError => e
  #       system 'clear'
  #       puts 'budget must be a integer number, please try again'
  #       retry
  #     end
  #     puts
  #     puts "Your budget is #{@player_budget}"
  #     puts
  # end

  #why the test gets stuck?
  def budget_input
    puts 'What\'s your budget?'
    puts "You can choose between 5000, 10000, 20000 or 50000"
    puts "Please choose one of the above options"
    begin
      @player_budget = Integer(gets.chomp)
      raise ArgumentError unless [5000, 10000, 20000, 50000].include? @player_budget
    rescue ArgumentError => e
      system 'clear'
      puts 'budget must be one of the following options:'
      puts '5000, 10000, 20000 or 50000'
      puts 'please try again'
      retry
    end
    puts
    puts "Your budget is #{@player_budget}"
    puts
  end

  def decks_input
    puts "How many decks shall we use #{@player_name}?"
    puts "We can play with: 1, 2, 4, 6 or 8 decks "
    puts "Please choose one of the above options"
    begin
      decks_input = gets.chomp
      @decks = Integer(decks_input)
      raise ArgumentError unless [1, 2, 4, 6, 8].include? Integer(decks_input)
    rescue ArgumentError
      system 'clear'
      puts 'the number of decks must be a integer number and one of the following options:'
      puts "1, 2, 4, 6 or 8"
      retry
    end
    puts
    puts "Ok #{@player_name}we\'ll play with #{@decks} decks"
    puts
  end

end
