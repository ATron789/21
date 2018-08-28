require 'hand'
require 'card'
require 'deck'

describe Hand do
  subject {Hand.new}
  it 'is a empty cards' do
    expect(subject.cards).to eq []
  end
  context 'holds cards' do
    let(:card) {Card.new(suit: 'C', rank: 4)}
    let(:cards_value) {Array.new}
    it 'has a card' do
      subject.cards << card
      expect(subject.cards.length).to eq 1
    end
  end

  context 'from a deck' do
    let(:deck) {Deck.new}
    it 'has a card from a deck' do
      deck.deal(subject.cards)
      expect(subject.cards.length).to eq 1
    end
    it 'has a 2 cards from a deck' do
      2.times {deck.deal(subject.cards)}
      expect(subject.cards.length).to eq 2
    end
    it 'the hand has a value ' do
      2.times {deck.deal(subject.cards)}
      expect(subject.hand_value).to be_between(1,21)
    end
  end

end
