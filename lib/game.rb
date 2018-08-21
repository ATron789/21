require_relative 'game_settings'

class Game
  attr_accessor :player, :house, :bet
  def initialize(player, house, bet)
    @player = player
    @house = house
    @bet = bet
  end

  def bet_input
    puts 'What\'s your bet?'
    loop do
      begin
        @bet = Integer(gets.chomp)
      rescue StandardError => e
        system 'clear'
        puts 'budget must be a integer number, please try again'
        retry
      end

      if @bet > player.budget
        puts 'the bet cannot be bigger than the user budget, try again'
        redo
      else
        break
      end
    end
  end
end
