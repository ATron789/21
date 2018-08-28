require 'game'
require 'pry'

describe Game do
  before(:each) do
    allow($stdout).to receive(:write)
  end
  let(:player) {Player.new(budget: 200)}
  let(:house) {House.new}
  let(:deck)  {Deck.new}

  subject {Game.new(player, house, deck)}
  context  'it accepts the right input' do
    it 'it accepts only the right bet: Integer and less than player budget' do
      allow(subject).to receive(:gets).and_return("ciao\n", "2000\n", "20\n")
      subject.bet_input
      expect(subject.bet).to eq 20
    end
  end

  # # context 'Bet input should raise an error' do
  # #   before do
  # #     allow(subject.bet_input).to receive(:gets).and_raise(ArgumentError)
  # #   end

  # #   it 'has to raise a error if bet is not valid' do
  # #     # allow(subject).to receive(:gets).and_return("ciao\n")
  # #     allow(subject).to receive(:bet_input).and_raise(ArgumentError)
  # #     # allow(subject).to receive(:gets).and_return("20\n")
  # #     # subject.bet_input
  # #     # binding.pry
  # #     expect{ subject.bet_input }.to raise_error(ArgumentError)
  # #   end
  #   #it just forces the method to raise an error, totally useless. it should not raise an error with 20 but it raises it anyway
  # end

end
