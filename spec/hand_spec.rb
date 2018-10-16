require 'hand'
require 'card'
require 'deck'
require 'pry'

describe Hand do
  let (:hand) {Hand.new}
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
      deck.deal(hand.cards)
      expect(hand.cards.length).to eq 1
    end
    it 'has a 2 cards from a deck' do
      2.times {deck.deal(hand.cards)}
      expect(hand.cards.length).to eq 2
    end
    it 'the hand has a value ' do
      2.times {deck.deal(hand.cards)}
      expect(hand.hand_value).to be_between(1,21)
    end
  end

  context 'ace checker' do
    it 'the hand has an ACE' do
      hand.cards.push(cards[:A], cards[8],cards[5])
      expect(hand.ace_check?).to be true
    end
    it 'the hand does not have an ACE' do
      hand.cards.push(cards[:K], cards[8])
      expect(hand.ace_check?).to be false
    end
  end

  context 'reset' do
    it 'drops the cards to start a new game' do
      hand.cards.push(cards[:K], cards[8], cards[5])
      hand.hand_reset
      expect(hand.cards).to eq []
    end
  end

  context 'soft hand' do
    it 'has a soft hand too' do
      hand.cards.push(cards[:A], cards[8])
      expect(hand.soft_hand_value).to eq hand.hand_value + 10
    end
  end

  context 'hard hand' do

    it 'does not have a soft hand' do
      hand.cards.push(cards[:K], cards[8])
      expect(hand.soft_hand_value).to be_falsey
    end
  end
  context 'best hand' do
    describe 'hand has a ace' do
      it 'if hand has an ace and soft_hand_value is < 21, returns soft hand' do
        hand.cards.push(cards[:A], cards[8])
        expect(hand.best_value).to eq hand.soft_hand_value
      end
      it 'if hand has an ace and soft_hand_value is = 21, returns soft hand' do
        hand.cards.push(cards[:A], cards[:K])
        expect(hand.best_value).to eq hand.soft_hand_value
      end
      it 'soft hand busted, returns hard hand' do
        hand.cards.push(cards[:A], cards[:K], cards[8])
        expect(hand.best_value).to eq hand.hand_value
      end
    end
    describe 'hand does not have an ace' do
      it 'returns hard hand' do
        hand.cards.push(cards[8], cards[:K])
        expect(hand.best_value).to eq hand.hand_value
      end
    end
  end

  context 'doubles' do
    it 'hands have 2 cards, same rank' do
      hand.cards.push(cards[:A], cards[:A])
      expect(hand.doubles?).to be true
    end
    it 'hands have 2 cards, different rank' do
      hand.cards.push(cards[:A], cards[8])
      expect(hand.doubles?).to be false
    end
    it 'hands has more than 2 cards' do
      hand.cards.push(cards[:A], cards[8], cards[5])
      binding.pry
      expect(hand.doubles?).to be false
    end
  end

end
