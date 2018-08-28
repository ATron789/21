require 'player'
require 'hand'

describe Player do
  let(:hand) {Hand.new}
  subject {Player.new(hand: hand)}

  it 'the house has an empty hand' do
    expect(subject.hand).to eq hand
  end
end
