require_relative 'card'
require_relative 'input_reader'

class Deck
  attr_reader :cards
  attr_accessor :number_of_decks
  def initialize(number_of_decks = 1)
    @ranks = [*(2..10), 'J', 'Q', 'K', 'A']
    @suits = ['C', 'H', 'S', 'D']
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
  def self.build(inputs)
    deck = self.new
    deck.number_of_decks = inputs.n_deck
    #why do I need this?
    deck
  end
  def deal(a)
    a << @cards.shift
  end
end
