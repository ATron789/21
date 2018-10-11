require 'player'
require 'deck'
require 'hand'

describe Player do
  let(:deck) {Deck.new}
  let(:player) {Player.new}
  let (:cards) do
    {
      :A => Card.new(suit: 'C', rank: 'A'),
      :K  => Card.new(suit: 'C', rank: 'K'),
      8 => Card.new(suit: 'C', rank: 8),
      5 => Card.new(suit: 'C', rank: 5)
    }
  end

  context 'busting' do
    it 'bustes if the hand value is > 21' do
      until player.hands[0].hand_value > 21 do
        deck.deal(player.hands[0].cards)
      end
      expect(player.hands[0].bust?).to eq true
    end
  end

  context 'budget' do
    it 'has no budget left' do
      allow(player).to receive(:budget).and_return(0)
      expect(player.no_budget?).to be true
    end
  end

  context 'from inputs' do
    let (:inputs) {InputReader.new(p_name: 'foo', p_budget: '5000')}
    it 'creates a new instance of player from inputs, name check' do
      new_player = Player.build(inputs)
      expect(new_player.name).to eq inputs.p_name
    end

    it 'creates a new instance of player from inputs, budget check' do
      new_player = Player.build(inputs)
      expect(new_player.budget).to eq inputs.p_budget
    end

  end
  context 'one hand' do
    it 'returns the best value for the hand' do
      player.hands[0].cards.push(cards[:A],cards[8])
      expect(player.best_hand).to eq player.hands[0].best_value
    end
    it 'return nil, if the only hand busts' do
      player.hands[0].cards.push(cards[:K],cards[8], cards[:K])
      expect(player.best_hand).to eq nil
    end

  end

  context 'more than one hands' do
    it 'returns the best hand of the set of hands' do
      player.hands.push(Hand.new)
      player.hands[0].cards.push(cards[:A],cards[:K])
      player.hands[1].cards.push(cards[:A],cards[8])
      expect(player.best_hand).to eq player.hands[0].best_value
    end
    it 'one is busted, returns the best hand of the set of hands' do
      player.hands.push(Hand.new)
      player.hands[0].cards.push(cards[:K],cards[8])
      player.hands[1].cards.push(cards[5],cards[8],cards[:K])
      expect(player.best_hand).to eq player.hands[0].best_value
    end

  end
end
