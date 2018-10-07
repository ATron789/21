require 'hand'
require 'card'
require 'deck'
require 'pry'

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
    let(:not_ace_card0) {Card.new(suit: 'C', rank: '8')}
    let(:not_ace_card1) {Card.new(suit: 'H', rank: '6')}

    it 'the hand has an ACE' do
      subject.cards << not_ace_card0
      subject.cards << not_ace_card1
      subject.cards << ace_card
      expect(subject.ace_check?).to be true
    end
    it 'the hand does not have an ACE' do
      subject.cards << not_ace_card0
      subject.cards << not_ace_card1
      expect(subject.ace_check?).to be false
    end
  end

  context 'reset' do
    it 'drops the cards to start a new game' do
      2.times {deck.deal(subject.cards)}
      subject.hand_reset
      expect(subject.cards).to eq []
    end
  end

  context 'soft hand' do
    let(:ace_card) {Card.new(suit: 'C', rank: 'A')}
    let(:reg_card) {Card.new(suit: 'S', rank: 8)}
    it 'has a soft hand too' do
      subject.cards << ace_card
      subject.cards << reg_card
      expect(subject.soft_hand_value).to eq subject.hand_value + 10
    end
  end

  context 'hard hand' do
    let(:face_card) {Card.new(suit: 'C', rank: 'K')}
    let(:reg_card) {Card.new(suit: 'S', rank: 8)}
    it 'does not have a soft hand' do
      subject.cards << face_card
      subject.cards << reg_card
      expect(subject.soft_hand_value).to be_falsey
    end
  end
  context 'best hand' do
    describe 'hand has a ace' do
      let(:ace_card) {Card.new(suit: 'C', rank: 'A')}
      let(:reg_card) {Card.new(suit: 'S', rank: 8)}
      let(:face_card) {Card.new(suit: 'C', rank: 'K')}
      it 'if hand has an ace and soft_hand_value is < 21, returns soft hand' do
        subject.cards << ace_card
        subject.cards << reg_card
        expect(subject.best_hand).to eq subject.soft_hand_value
      end
      it 'if hand has an ace and soft_hand_value is = 21, returns soft hand' do
        subject.cards << ace_card
        subject.cards << face_card
        expect(subject.best_hand).to eq subject.soft_hand_value
      end
      it 'soft hand busted, returns hard hand' do
        subject.cards << ace_card
        subject.cards << reg_card
        subject.cards << face_card
        expect(subject.best_hand).to eq subject.hand_value
      end
    end
    describe 'hand does not have an ace' do
      let(:reg_card) {Card.new(suit: 'S', rank: 8)}
      let(:face_card) {Card.new(suit: 'C', rank: 'K')}
      it 'soft hand busted, returns hard hand' do
        subject.cards << reg_card
        subject.cards << face_card
        expect(subject.best_hand).to eq subject.hand_value
      end
    end
  end

  context 'splitting' do
    it 'player chooses to have to set of hands' do
      
    end
  end

end
