require 'game_settings'

describe GameSettings do
  subject {GameSettings.new('foo', 200, 3)}
  context 'GameSettings set player\'s attributes' do
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
    it 'set\'s the number of decks' do
      expect(deck.number_of_decks).to eq 3
    end
  end
end
