require 'player'
require 'deck'
require 'hand'

describe Player do
  let(:hand) {Hand.new}
  let(:deck) {Deck.new}
  subject {Player.new}

  it 'the house has an empty hand' do
    expect(subject.hand.cards).to eq hand.cards
  end
  it 'bustes if the hand value is > 21' do
    until subject.hand.hand_value > 21 do
      deck.deal(subject.hand.cards)
    end
    expect(subject.bust?).to eq true
  end
  context 'budget' do
    it 'has no budget left' do
      allow(subject).to receive(:budget).and_return(0)
      expect(subject.no_budget?).to be true
    end
  end
end
