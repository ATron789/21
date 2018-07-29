require 'deck'

describe Deck do
  subject {Deck.new.cards}
  it 'is a full deck of 52 cards' do
    raise unless subject.length == 52
  end
  it 'has all different cards' do
    raise unless subject.uniq.length == subject.length
  end
  context 'number of decks' do
    subject {Deck.new (2)}
    it 'check the number of decks' do
      raise unless subject.cards.length / 52 == subject.number_of_decks
    end
    it 'has NOT all different cards' do
      raise unless subject.cards.uniq.length != subject.cards.length
    end
  end
end
