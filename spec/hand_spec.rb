require 'hand'
require 'card'
require 'deck'

describe Hand do
  subject {Hand.new}
  it 'is a empty cards' do
    expect(subject.cards).to eq []
  end
  context 'holds cards' do
    before(:each) do
      subject.cards << card
    end
    let(:card) {Card.new(suit: 'C', rank: 4)}
    it 'has a card' do
      expect(subject.cards.length).to eq 1
    end
    it 'shows the cards' do
      expect{subject.show_cards}.to output("The #{card.rank} of #{card.suit}\n").to_stdout
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

end
