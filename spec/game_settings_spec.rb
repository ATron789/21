require 'game_settings'

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
    it 'receives a budget input' do
      allow(subject).to receive(:gets).and_return("200\n")
      subject.budget_input
      expect(subject.player_budget).to eq 200
    end
    it 'receives a number of decks input' do
      allow(subject).to receive(:gets).and_return("3\n")
      subject.decks_input
      expect(subject.decks).to eq 3
    end

  end
  context 'GameSettings set player\'s attributes' do
    subject {GameSettings.new('foo', 200, 3)}
    let(:player1) {Player.build(subject)}
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
