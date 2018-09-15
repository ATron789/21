require_relative 'player'
class InputReader
  attr_accessor :name, :budget, :bet, :decks, :player
  def initialize(player)
    @player = player
  end

  def name_input
    puts 'What should I call you'
    user_name = gets.chomp
    @name = user_name unless user_name.empty?
  end

  def budget_input
    puts 'What\'s your budget?'
    begin
      @budget = Integer(gets.chomp)
    rescue ArgumentError
      system 'clear'
      puts 'budget must be a integer number, please try again'
      retry
    end
  end

  def decks_input
    puts "How many decks shall we use #{@name}?"
    begin
      @decks = Integer(gets.chomp)
    rescue ArgumentError
      system 'clear'
      puts 'the number of decks must be a integer number, please try again'
      retry
    end
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

    if bet > player.budget
        #why this work even if player is not called as instance variable
        puts 'the bet cannot be bigger than the user budget, try again'
        bet_input
    end
  end

end
