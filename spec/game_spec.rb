require 'game'
require 'input_reader'
require 'pry'

describe Game do
  before(:each) do
    allow($stdout).to receive(:write)
  end

  let (:cards) do
    {
      :A => Card.new(suit: 'C', rank: 'A'),
      :K  => Card.new(suit: 'C', rank: 'K'),
      8 => Card.new(suit: 'C', rank: 8),
      5 => Card.new(suit: 'C', rank: 5)
    }
  end

  let(:deck)  {Deck.new}
  let(:player) {Player.new(budget: 5000)}
  let(:house) {House.new}
  subject {Game.new(player, house, deck)}

  context  'it accepts the right input' do
    it 'it accepts only the right bet: Integer and less than player budget' do
      allow(subject).to receive(:gets).and_return("ciao\n", "6000\n", "20\n")
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

  context 'hit or stand' do
    it 'when hit receive a card till it busts' do
      allow(subject).to receive(:gets).and_return("no", "h\n")
      player.hand.cards.push(cards[5],cards[8])
      house.hand.cards.push(cards[:K],cards[8])
      subject.hit_or_stand
      expect(player.hand.cards.length).to be > 2
      expect(player.bust?).to be_truthy
    end
    it 'it stands' do
      allow(subject).to receive(:gets).and_return("s")
      subject.deal_the_cards
      subject.hit_or_stand
      expect(player.hand.cards.length).to eq 2
    end

    it 'stays on a soft hand' do
      player.hand.cards.push(cards[:A],cards[8])
      house.hand.cards.push(cards[:K],cards[8])
      allow(subject).to receive(:gets).and_return("s")
      subject.hit_or_stand
      expect{subject.house_logic}.to output{"#{player.name} has a soft #{player.hand.soft_hand_value}"}.to_stdout
    end
    it 'players got a blackjack' do
      player.hand.cards.push(cards[:A],cards[:K])
      house.hand.cards.push(cards[:K],cards[8])
      subject.hit_or_stand
      expect{subject.hit_or_stand}.to output{'BLACKJACK!'}.to_stdout
      expect(subject.player.hand.best_hand).to eq player.hand.soft_hand_value
    end
  end

  describe 'house logic' do

    context 'house hitting, house hand value less than player' do
      it 'hits because less than player' do
        player.hand.cards.push(cards[:K],cards[:K])
        house.hand.cards.push(cards[8], cards[:K])
        house_original_hand = house.hand.cards.length
        subject.house_logic
        expect(house.hand.cards.length).to_not eq house_original_hand
      end
    end

    context 'house hitting, house hand value less than 17' do
      it 'hits because less than 17' do
        player.hand.cards.push(cards[:K],cards[8])
        house.hand.cards.push(cards[:K], cards[5])
        house_original_hand = house.hand.cards.length
        subject.house_logic
        expect(house.hand.cards.length).to_not eq house_original_hand
      end
    end

    context 'house hitting, house hand value less than 17. Player less than 17' do
      it 'hits because less than 17' do
        player.hand.cards.push(cards[:K],cards[5])
        house.hand.cards.push(cards[:K], cards[5])
        house_original_hand = house.hand.cards.length
        subject.house_logic
        expect(house.hand.cards.length).to_not eq house_original_hand
      end
    end

    context 'house stands, more than player and more than 17' do
      it 'hits stands' do
        player.hand.cards.push(cards[:K],cards[8])
        house.hand.cards.push(cards[:K], cards[8])
        house_original_hand = house.hand.cards.length
        subject.house_logic
        expect(house.hand.cards.length).to eq house_original_hand
      end
    end

    context 'blackjack' do
      it 'house got a blackjack'do
      house.hand.cards.push(cards[:A],cards[:K])
      player.hand.cards.push(cards[:K],cards[8])
      subject.house_logic
      expect{subject.house_logic}.to output{'BLACKJACK!'}.to_stdout
      expect(subject.house.hand.best_hand).to eq house.hand.soft_hand_value
      end
    end


    context 'house behaviour about busting' do
      it 'Player busts house does nothing' do
        allow(player).to receive(:bust?).and_return(true)
        expect(subject.house_logic).to eq nil
      end
      it 'House busts, player wins' do
        allow(house).to receive(:bust?).and_return(true)
        expect{subject.house_logic}.to output{"#{house.name} busted, #{player.name} wins\n"}.to_stdout
      end
    end

  end

  context 'bet handling' do

    it 'player wins, player hand bigger than house' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:A],cards[8])
      subject.house.hand.cards.push(cards[:K],cards[8])
      subject.winner
      expect(player.budget).to eq initial_pbudget += subject.bet
    end

    it 'player won with a blackjack' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:A],cards[:K])
      subject.house.hand.cards.push(cards[:K],cards[8])
      subject.winner
      expect(player.budget).to eq initial_pbudget += (subject.bet * 3)/2
      expect{subject.winner}.to output{"#{player.name} wins #{(@bet * 3) / 2}"}.to_stdout
    end


    it 'player wins, house busted' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:A],cards[8])
      subject.house.hand.cards.push(cards[:K],cards[8], cards[5])
      subject.winner
      expect(player.budget).to eq initial_pbudget += subject.bet
    end

    it 'house wins, players loses the bet' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:K],cards[8])
      subject.house.hand.cards.push(cards[:A],cards[8])
      subject.winner
      expect(player.budget).to eq initial_pbudget -= subject.bet
    end

    it 'house wins, player busted' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:K],cards[8], cards[5])
      subject.house.hand.cards.push(cards[:A],cards[8])
      binding.pry
      subject.winner
      expect(player.budget).to eq initial_pbudget -= subject.bet
    end

    it 'tie, bets are null' do
      initial_pbudget = player.budget
      subject.bet = 20
      subject.player.hand.cards.push(cards[:A],cards[:K])
      subject.house.hand.cards.push(cards[:A],cards[:K])
      subject.winner
      expect(player.budget).to eq initial_pbudget
    end
  end
  context 'main game' do
    it 'plays, runs out of budget, then game over'do
      allow(player).to receive(:no_budget?).and_return(true)
      allow(subject).to receive(:gets).and_return('20', 's')
      subject.play
      expect{subject.winner}.to output{"#{player.name} run has no budget left, game over"}.to_stdout
    end
  end
end
