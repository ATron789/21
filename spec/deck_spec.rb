require 'deck'
require 'input_reader'
require 'hand'

describe Deck do
  context 'one deck scenario' do
    subject {Deck.new.cards}
    it 'is a full deck of 52 cards' do
      expect(subject.length).to eq 52
    end
    it 'has all different cards' do
      raise unless subject.uniq.length == subject.length
    end
  end
  context 'More than one deck' do
    subject {Deck.new (2)}
    let (:hand) {Hand.new}
    it 'check the number of decks' do
      raise unless subject.cards.length / 52 == subject.number_of_decks
    end
    it 'has NOT all different cards' do
      raise unless subject.cards.uniq.length != subject.cards.length
    end
    it 'it deals 2 cards' do
      2.times {subject.deal(hand.cards)}
      expect(hand.cards.length).to eq 2
    end
  end
  context 'from inputs' do
    let (:inputs) {InputReader.new(n_deck: 8)}
    it 'creates a new instance of Deck from inputs' do
      new_deck = Deck.build(inputs)
      expect(new_deck.number_of_decks).to eq inputs.n_deck
    end
  end
end
