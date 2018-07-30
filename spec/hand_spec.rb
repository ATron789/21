require 'hand'
require 'card'
require 'deck'
describe Hand do
  subject {Hand.new}
  it 'is a empty hand' do
    raise unless subject.hand == []
  end
  context 'holds cards' do
    let(:card) {Card.new(suit: '♣', rank: 4)}
    it 'has a card' do
      subject.hand << card
      expect(subject.hand.length).to eq 1
    end
    it 'has 2 cards' do
      2.times {subject.hand << card}
      expect(subject.hand.length).to eq 2
    end
  end
  context 'from a deck' do
    let(:deck) {Deck.new}
    it 'has a card from a deck' do
      subject.hand << deck.deal
      expect(subject.hand.length).to eq 1
    end
    it 'has a 2 cards from a deck' do
      2.times {subject.hand << deck.deal}
      expect(subject.hand.length).to eq 2
    end
  end
end
