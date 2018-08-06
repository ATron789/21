require_relative 'card'
class Deck
  attr_reader :cards, :number_of_decks
  def initialize(number_of_decks = 1)
    @ranks = [*(2..10), 'J', 'Q', 'K', 'A']
    @suits = ['♣', '♥', '♠', '♦']
    @cards = []
    @number_of_decks = number_of_decks

    number_of_decks.times do
      @ranks.each do |rank|
        @suits.each do |suit|
          @cards << Card.new(rank: rank, suit:suit)
        end
      end
    end
  @cards.shuffle!
  end

  def deal
    @cards.shift
  end
end
