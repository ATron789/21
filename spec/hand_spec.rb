require 'hand'
require 'card'
require 'deck'

describe Hand do
  subject {Hand.new}
  let(:deck) {Deck.new}

  context 'from a deck' do
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

  context 'ace checker' do
    let(:ace_card) {Card.new(suit: 'C', rank: 'A')}
    let(:not_ace_card) {Card.new(suit: 'C', rank: '8')}

    it 'the hand has an ACE' do
      subject.cards << ace_card
      expect(subject.ace_check).to be true
    end
    it 'the hand does not have an ACE' do
      subject.cards << not_ace_card
      expect(subject.ace_check).to be false
    end
  end

  context 'reset' do
    it 'drops the cards to start a new game' do
      2.times {deck.deal(subject.cards)}
      subject.hand_reset
      expect(subject.cards).to eq []
    end
  end

end
