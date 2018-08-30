require 'game_settings'
require 'pry'

describe GameSettings do
  before(:each) do
    allow($stdout).to receive(:write)
  end
  context 'inputs' do
    subject {GameSettings.new}
    it 'receives a name input' do
      allow(subject).to receive(:gets).and_return("Brian\n")
      subject.name_input
      expect(subject.player_name).to eq "Brian"
    end
    it 'does not receive a name input' do
      allow(subject).to receive(:gets).and_return("\n")
      subject.name_input
      expect(subject.player_name).to eq "Player"
    end
    it 'accepts only the correct budget input' do
      allow(subject).to receive(:gets).and_return("ciao\n", "200\n")
      subject.budget_input
      expect(subject.player_budget).to eq 200
    end
    it 'accepts only the correct input' do
      allow(subject).to receive(:gets).and_return("ciao\n", "3\n")
      subject.decks_input
      expect(subject.decks).to eq 3
    end

    # context 'decks_input raises an error' do
    #   # before do
    #   #   allow(subject.bet_input).to receive(:gets).and_raise(ArgumentError)
    #   # end
    #
    #   it 'has to raise a error if decks input is not valid' do
    #     allow(subject).to receive(:decks_input).and_raise(ArgumentError)
    #     allow(subject).to receive(:gets).and_return("ciao\n")
    #     # subject.bet_input
    #     # binding.pry
    #     expect{ subject.decks_input }.to raise_error(ArgumentError)
    #   end
    #   #it just forces the method to raise an error



  end
  context 'GameSettings set player\'s attributes' do
    subject {GameSettings.new('foo', 200, 3)}
    let(:player1) {Player.build(subject)}
    # binding.pry
    it 'sets player\'s name' do
      expect(player1.name).to eq 'foo'
    end
    it 'sets player\'s budget' do
      expect(player1.budget).to eq 200
    end
  end
  context 'GameSettings set deck\'s attributes' do
    let(:deck) {Deck.build(subject)}
    subject {GameSettings.new('foo', 200, 3)}
    it 'set\'s the number of decks' do
      expect(deck.number_of_decks).to eq 3
    end
  end
end
