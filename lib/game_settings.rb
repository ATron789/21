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

  def name_input
    puts 'What should I call you'
    user_name = gets.chomp
    @player_name = user_name unless user_name.empty?
  end

  def budget_input
    puts 'What\'s your budget?'
    begin
      @player_budget = Integer(gets.chomp)
    rescue StandardError => e
      system 'clear'
      puts 'budget must be a integer number, please try again'
      retry
    end
  end
#the following function is for test purposes.
#For recursive function
  def budget_input2(attempted = false)
    system 'clear' if attempted
    message = attempted ?
      'budget must be a integer number, please try again' :
      'What\'s your budget?'
    puts message
    @player_budget = Integer(gets.chomp)
    rescue StandardError => e
      budget_input2(true)
  end


  def decks_input
    puts "How many decks shall we use #{@player_name}?"
    begin
      @decks = Integer(gets.chomp)
    rescue StandardError => e
      system 'clear'
      puts 'the number of decks must be a integer number, please try again'
      retry
    end
  end
end
