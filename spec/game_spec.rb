require 'game'
require 'pry'

describe Game do
  before(:each) do
    allow($stdout).to receive(:write)
  end
  let(:deck)  {Deck.new}
  let(:player) {Player.new(budget: 200)}
  let(:house) {House.new}


  subject {Game.new(player, house, deck)}
  context  'it accepts the right input' do
    it 'it accepts only the right bet: Integer and less than player budget' do
      allow(subject).to receive(:gets).and_return("ciao\n", "2000\n", "20\n")
      subject.bet_input
      expect(subject.bet).to eq 20
    end
  end
  context 'card dealing' do
    it 'the house and the player receive 2 cards' do
      subject.deal_the_cards
      expect(player.hand.cards.length).to eq 2
      expect(house.hand.cards.length).to eq 2
    end
  end
end
