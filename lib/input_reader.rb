class InputReader
  attr_accessor :name, :budget, :bet, :decks

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
    puts "How many decks shall we use #{@player_name}?"
    begin
      @decks = Integer(gets.chomp)
    rescue ArgumentError
      system 'clear'
      puts 'the number of decks must be a integer number, please try again'
      retry
    end
  end

end
