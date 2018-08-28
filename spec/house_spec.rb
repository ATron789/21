require 'house'
require 'hand'

describe House do
  let(:hand) {Hand.new}
  subject {House.new(hand: hand)}

  it 'the house has an empty hand' do
    expect(subject.hand).to eq hand
  end
end
