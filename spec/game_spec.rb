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
    it 'the house and the player receive 1 card each' do
      subject.deal_one_card
      expect(player.hand.cards.length).to eq 1
      expect(house.hand.cards.length).to eq 1
    end

    it 'the house and the player receive 2 cards' do
      subject.deal_the_cards
      expect(player.hand.cards.length).to eq 2
      expect(house.hand.cards.length).to eq 2
    end
  end

  context 'hit or stand'
  it 'when hit receive a card till it busts' do
    allow(subject).to receive(:gets).and_return("no", "h\n")
    subject.deal_the_cards
    subject.hit_or_stand
    expect(player.hand.cards.length).to be > 2
    expect(player.bust?).to be_truthy
  end
  it 'it stands' do
    allow(subject).to receive(:gets).and_return("s\n")
    subject.deal_the_cards
    subject.hit_or_stand
    expect(player.hand.cards.length).to eq 2
  end
end
