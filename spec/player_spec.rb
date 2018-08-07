require 'player'
require 'deck'

describe Player do
  subject {Player.new}
  it 'the player has an empty hand' do
    expect(subject.hand).to eq Array.new
  end
  context 'receiving cards from Deck(s)' do
    let(:deck) {Deck.new}
    it 'has a 2 cards from a deck' do
      2.times {subject.hand << deck.deal}
      expect(subject.hand.length).to eq 2
    end
    it 'the hand has a value > 0' do
      2.times {subject.hand << deck.deal}
      expect(subject.hand.inject { |x,sum| x.value + sum.value}).to be_between(1, 21)
    end
  end
end
