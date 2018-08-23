require 'game'

describe Game do
  before(:each) do
    allow($stdout).to receive(:write)
  end
  let(:player) {Player.new('pippo', [], 200)}
  let(:house) {House.new}
  let(:deck)  {Deck.new}

  subject {Game.new(player, house, deck)}
  context 'Bet input' do
    it 'has a bet input' do
      allow(subject).to receive(:gets).and_return("ciao\n", "2000\n", "200\n")
      subject.bet_input
      expect(subject.bet).to eq 200
    end
    # it 'has to raise a error if bet is not valid' do
    #   allow(subject).to receive(:gets).and_return("ciao\n")
    #   expect{subject.bet_input}.to raise_error(ArgumentError)
    # end
  end


  it 'deals cards' do
    subject.deal_the_cards
    expect(player.hand.inject { |x,sum| x.value + sum.value}).to be_between(1, 21)
    expect(house.hand.inject { |x,sum| x.value + sum.value}).to be_between(1, 21)
    expect(subject.player.hand).to eq player.hand
  end
end
