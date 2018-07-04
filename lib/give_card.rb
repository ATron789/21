# class CardGiver
#   @@rank = [:ace, *2..10, :jack, :queen, :king]
#   @@suit = [:spades, :hearts, :diamonds, :clubs]
#
#   attr_accessor :suit, :rank
#   def initialize
#     @rank = @@rank.sample
#     @suit = @@suit.sample
#   end
# end
class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  # def output_card
  #   puts "The #{@rank} of #{@suit}"
  # end
end

class Deck
  attr_reader :cards, :ranks, #:dealt_card
  def initialize
    @ranks = [*(2..10), 'J', 'Q', 'K', 'A']
    @suits = ['♣', '♥', '♠', '♦']
    @cards = []

    @ranks.each do |rank|
      @suits.each do |suit|
        @cards << [rank, suit]
        # Card.new(rank, suit)
      end
    end
  @cards.shuffle!
  end

  def output_card(card)
    puts "The #{card[0][0]} of #{card[0][1]}"
  end
  def deal
     @dealt_card = @cards.shift
  end

  # def output_card(card)
  #   puts "The #{card[0][0]} of #{card[0][1]}"
  # end
  # def deal
  #   number.times {@cards.shift.output_card}
  # end
end
