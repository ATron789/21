require 'game'

describe Game do
  before(:each) do
    allow($stdout).to receive(:write)
  end
  let(:player) {Player.new('pippo', [], 200)}
  let(:house) {House.new}
  let(:deck)  {Deck.new}

  subject {Game.new(player, house, deck)}

  it 'has a bet input' do
    allow(subject).to receive(:gets).and_return("200\n")
    subject.bet_input
    expect(subject.bet).to eq 200
  end
  #check recursive method to get out of the loop
  it 'has to raise a error if bet is not valid' do
    allow(subject).to receive(:gets).and_return("200000\n")
    subject.bet_input
    expect(subject.bet_input).to raise_error
  end


  it 'deals cards' do
    subject.deal_the_cards
    expect(player.hand.inject { |x,sum| x.value + sum.value}).to be_between(1, 21)
    expect(house.hand.inject { |x,sum| x.value + sum.value}).to be_between(1, 21)
    expect(subject.player.hand).to eq player.hand
  end
end
