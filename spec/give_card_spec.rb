require 'give_card'
suit = [:spades, :hearts, :diamonds, :clubs]
rank = [:ace, *2..10, :jack, :queen, :king]

describe CardGiver do
  it 'gives a card' do
    raise unless CardGiver.new
  end
  it 'has a suit' do
    raise unless suit.include? CardGiver.new.suit
  end
  it 'has a rank' do
    raise unless rank.include? CardGiver.new.rank
  end
end
