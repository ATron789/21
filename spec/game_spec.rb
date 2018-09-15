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

  context 'hit or stand' do
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
  context 'house logic' do
    context 'house hitting' do
      it 'asks for a card if the house hand is less than player' do
        subject.deal_the_cards
        house_original_hand = house.hand.hand_value
        player_original_hand = player.hand.hand_value
        subject.house_logic
        if house_original_hand <= player_original_hand || house_original_hand < 17
          # binding.pry
          expect(house.hand.cards.length).to_not eq 2
        elsif house_original_hand == player_original_hand && house_original_hand >= 17
          # binding.pry
          expect(house.hand.cards.length).to eq 2
        else
          # binding.pry
          expect(house.hand.cards.length).to eq 2
        end
      end
      context 'house behaviour about busting' do
        it 'Player busts house does nothing' do
          allow(player).to receive(:bust?).and_return(true)
          expect(subject.house_logic).to eq nil
        end
        it 'House busts, player wins' do
          allow(house).to receive(:bust?).and_return(true)
          expect{subject.house_logic}.to output("#{house.name} busted, #{player.name} wins\n").to_stdout
        end
        it 'tie scenario' do
          player.hand = house.hand
          expect{subject.house_logic}.to output{"#{house.name} got\n" ; house.hand.show_cards ; "it\' a tie!"}.to_stdout
        end
      end
      context 'bet' do
        it 'player wins, player hand bigger than house' do
          initial_pbudget = player.budget
          subject.bet = 20
          allow(player.hand).to receive(:hand_value).and_return(18)
          allow(house.hand).to receive(:hand_value).and_return(17)
          subject.winner
          # binding.pry
          expect(player.budget).to eq initial_pbudget += subject.bet
          # expect(player.budget).to_not eq initial_pbudget
        end

        it 'player wins, house busted' do
          initial_pbudget = player.budget
          subject.bet = 20
          allow(player.hand).to receive(:hand_value).and_return(18)
          allow(house.hand).to receive(:hand_value).and_return(22)
          allow(house).to receive(:bust?).and_return(true)
          subject.winner
          # binding.pry
          expect(player.budget).to eq initial_pbudget += subject.bet
        end

        it 'house wins, players loses the bet' do
          initial_pbudget = player.budget
          subject.bet = 20
          allow(player.hand).to receive(:hand_value).and_return(17)
          allow(house.hand).to receive(:hand_value).and_return(18)
          subject.winner
          # binding.pry
          expect(player.budget).to eq initial_pbudget -= subject.bet
          # expect(player.budget).to_not eq initial_pbudget
        end

        it 'house wins, players busted' do
          initial_pbudget = player.budget
          subject.bet = 20
          allow(player.hand).to receive(:hand_value).and_return(22)
          allow(house.hand).to receive(:hand_value).and_return(18)
          allow(player).to receive(:bust?).and_return(true)
          subject.winner
          # binding.pry
          expect(player.budget).to eq initial_pbudget -= subject.bet
          # expect(player.budget).to_not eq initial_pbudget
        end

      end

    end

  end
end
