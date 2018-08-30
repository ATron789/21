require 'house'
require 'hand'

describe House do
  let(:hand) {Hand.new}
  subject {House.new}

  it 'the house has an empty hand' do
    expect(subject.hand.cards).to eq hand.cards
  end
end
