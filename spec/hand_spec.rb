require 'hand'
require 'card'
require 'deck'
require 'pry'

describe Hand do
  subject {Hand.new}
  let(:deck) {Deck.new}
  let (:cards) do
    {
      :A => Card.new(suit: 'C', rank: 'A'),
      :K  => Card.new(suit: 'C', rank: 'K'),
      8 => Card.new(suit: 'C', rank: 8),
      5 => Card.new(suit: 'C', rank: 5)
    }
  end

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


    it 'the hand has an ACE' do
      subject.cards.push(cards[:A], cards[8],cards[5])
      expect(subject.ace_check?).to be true
    end
    it 'the hand does not have an ACE' do
      subject.cards.push(cards[:K], cards[8])
      expect(subject.ace_check?).to be false
    end
  end

  context 'reset' do
    it 'drops the cards to start a new game' do
      subject.cards.push(cards[:K], cards[8], cards[5])
      subject.hand_reset
      expect(subject.cards).to eq []
    end
  end

  context 'soft hand' do
    it 'has a soft hand too' do
      subject.cards.push(cards[:A], cards[8])
      expect(subject.soft_hand_value).to eq subject.hand_value + 10
    end
  end

  context 'hard hand' do

    it 'does not have a soft hand' do
      subject.cards.push(cards[:K], cards[8])
      expect(subject.soft_hand_value).to be_falsey
    end
  end
  context 'best hand' do
    describe 'hand has a ace' do
      it 'if hand has an ace and soft_hand_value is < 21, returns soft hand' do
        subject.cards.push(cards[:A], cards[8])
        expect(subject.best_value).to eq subject.soft_hand_value
      end
      it 'if hand has an ace and soft_hand_value is = 21, returns soft hand' do
        subject.cards.push(cards[:A], cards[:K])
        expect(subject.best_value).to eq subject.soft_hand_value
      end
      it 'soft hand busted, returns hard hand' do
        subject.cards.push(cards[:A], cards[:K], cards[8])
        expect(subject.best_value).to eq subject.hand_value
      end
    end
    describe 'hand does not have an ace' do
      it 'returns hard hand' do
        subject.cards.push(cards[8], cards[:K])
        expect(subject.best_value).to eq subject.hand_value
      end
    end
  end

  context 'splitting' do
    it 'player chooses to have to set of hands' do

    end
  end

end
