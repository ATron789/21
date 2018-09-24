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

  context 'from inputs' do
    let (:inputs) {InputReader.new(p_name: 'foo', p_budget: '5000')}
    it 'creates a new instance of player from inputs, name check' do
      new_player = Player.build(inputs)
      expect(new_player.name).to eq inputs.p_name
    end

    it 'creates a new instance of player from inputs, budget check' do
      new_player = Player.build(inputs)
      expect(new_player.budget).to eq inputs.p_budget
    end
  
  end
end
