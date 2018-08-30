require 'player'
require 'hand'

describe Player do
  let(:hand) {Hand.new}
  subject {Player.new}

  it 'the house has an empty hand' do
    expect(subject.hand.cards).to eq hand.cards
  end
end
