require 'set'
require 'card'
describe Card do
  let (:suits) {['H', 'C', 'S', 'D']}
  let (:ranks) {[*(2..10), 'J', 'Q', 'K', 'A']}
  def card(params = {})
    defaults = {rank: 7, suit: 'H'}
    Card.new(**defaults.merge(params))
  end
  it 'has a rank' do
    expect(ranks.include? card.rank).to be true
  end
  it 'has a suit' do
    expect(suits.include? card.suit).to eq true
  end
  it 'has a value that equals the rank' do
    expect(card.value).to eq 7
  end
  it 'face cards value equals 10' do
    expect(card(rank: 'K').value).to eq 10
  end
  context 'equality' do
    subject {card(suit: 'C', rank: 4)}

    describe 'comparing against iself' do
      let(:other) {card(suit: 'C', rank: 4)}

      it 'is equal to itself' do
        raise unless subject == other
      end
      it 'is hash equal to itself' do
        raise unless Set.new([subject, other]).size == 1
      end
    end

    shared_examples_for 'an unequal card' do
      it 'is not equal' do
        raise unless subject != other
      end
      it 'is not hash equal' do
        raise unless Set.new([subject, other]).size == 2
      end
    end

    describe 'comparing to a card of different suit' do
      let(:other) {card(suit: 'H', rank: 4)}
      it_behaves_like 'an unequal card'
    end
    describe 'comparing to a card of different rank' do
      let(:other) {card(suit: 'C', rank: 8)}
      it_behaves_like 'an unequal card'
    end
  end
end
