require 'game'
require 'input_reader'
require 'pry'

describe Game do

  before(:each) do
    allow(RightInput).to receive(:yes_or_no).and_return("n")
    allow($stdout).to receive(:write)
  end

  let (:cards) do
    {
      :A => Card.new(suit: 'C', rank: 'A'),
      :K  => Card.new(suit: 'C', rank: 'K'),
      8 => Card.new(suit: 'C', rank: 8),
      5 => Card.new(suit: 'C', rank: 5),
      7 => Card.new(suit: 'C', rank: 5),
      2 => Card.new(suit: 'C', rank: 2)
    }
  end

  let(:deck)  {Deck.new}
  let(:player) {Player.new(budget: 5000)}
  let(:house) {House.new}
  let(:game) {Game.new(player, house, deck)}

  context  'it accepts the right input' do
    it 'it accepts only the right bet: Integer and less than player budget' do
      allow(game).to receive(:gets).and_return("ciao\n", "6000\n", "20\n")
      game.bet_input
      expect(game.bet).to eq 20
    end
  end

  context 'card dealing' do
    it 'the house and the player receive 1 card each' do
      game.deal_one_card
      expect(player.hands[-1].cards.length).to eq 1
      expect(house.hand.cards.length).to eq 1
    end

    it 'the house and the player receive 2 cards' do
      game.deal_the_cards
      expect(player.hands[-1].cards.length).to eq 2
      expect(house.hand.cards.length).to eq 2
    end
  end

  context 'splitting' do

    before(:each) do
      allow(RightInput).to receive(:yes_or_no).and_return("y")
    end

    describe 'on one hand' do
      #sometimes it goes for more than 2
      it 'player has a hand with 2 cards, he/she decides to split, first input wrong' do
        player.hands[0].cards.push(cards[5],cards[5])
        # allow(RightInput).to receive(:yes_or_no).and_return("y")
        game.splitting(player.hands[0])
        expect(player.hands.length).to be > 1
      end

      it 'player has a hand with 2 cards, he/she decides not to split' do
        player.hands[0].cards.push(cards[5],cards[5])
        allow(RightInput).to receive(:yes_or_no).and_return("n")
        game.splitting(player.hands[0])
        expect(player.hands.length).not_to eq 2
      end
    end

    describe 'more than one hand' do
      before(:each) do
        player.hands.push(Hand.new)
      end

      it '2 hands, splits both' do
        #sometimes it gives more than 4
        player.hands[0].cards.push(cards[5],cards[5])
        player.hands[1].cards.push(cards[5],cards[5])
        game.splitting(player.hands[0])
        game.splitting(player.hands[1])
        expect(player.hands.length).to be > 2
      end

      it '2 hands, splits on one' do
        #sometimes it gives more than 3
        player.hands[0].cards.push(cards[:K],cards[:K])
        player.hands[1].cards.push(cards[5],cards[5])
        allow(RightInput).to receive(:yes_or_no).and_return("n", "y")
        game.splitting(player.hands[0])
        game.splitting(player.hands[1])
        expect(player.hands.length).to eq 3
      end

      it '2 hands, does not split on any' do
        player.hands[0].cards.push(cards[:K],cards[:K])
        player.hands[1].cards.push(cards[8],cards[8])
        allow(RightInput).to receive(:yes_or_no).and_return("n")
        game.splitting(player.hands[0])
        game.splitting(player.hands[1])
        expect(player.hands.length).to eq 2
      end

    end
  end

  context 'hit or stand' do

    describe 'player has one hand' do
      it 'when hit receive a card till it busts' do
        player.hands[0].cards.push(cards[5],cards[8])
        house.hand.cards.push(cards[:K],cards[8])
        allow(RightInput).to receive(:hit_stand).and_return("h")
        game.hit_or_stand
        expect(player.hands[0].cards.length).to be > 2
        expect(player.hands[0].bust?).to be_truthy
      end
      it 'it stands' do
        allow(RightInput).to receive(:hit_stand).and_return("s")
        game.deal_the_cards
        game.hit_or_stand
        expect(player.hands[0].cards.length).to eq 2
      end

      it 'stays on a soft hand' do
        player.hands[0].cards.push(cards[:A],cards[8])
        house.hand.cards.push(cards[:K],cards[8])
        allow(RightInput).to receive(:hit_stand).and_return("s")
        expect{game.hit_or_stand}.to output{"#{player.name} has a soft #{player.hands[0].soft_hand_value}"}.to_stdout
      end
      it 'player got a blackjack' do
        player.hands[0].cards.push(cards[:A],cards[:K])
        house.hand.cards.push(cards[:K],cards[8])
        game.hit_or_stand
        expect{game.hit_or_stand}.to output{'BLACKJACK!'}.to_stdout
        expect(game.player.hands[0].best_value).to eq player.hands[0].soft_hand_value
      end
    end

    describe 'player has more than 1 one hand' do
      before(:each) do
        player.hands.push(Hand.new)
      end
      it 'hits because less than one of the player hands' do
        player.hands[0].cards.push(cards[5],cards[8])
        player.hands[1].cards.push(cards[:K],cards[8])
        house.hand.cards.push(cards[5], cards[:K])
        allow(RightInput).to receive(:hit_stand).and_return('h','s')
        game.hit_or_stand
        expect(player.hands[0].cards.length).to be > 2
        expect(player.hands[1].cards.length).to eq 2
      end

    end


  end


  describe 'house logic' do

    context 'player has only one hand ' do

        it 'house hits because less than player' do
          player.hands[0].cards.push(cards[:K],cards[:K])
          house.hand.cards.push(cards[8], cards[:K])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to_not eq house_original_hand
        end

        it 'house hits because less than 17' do
          player.hands[0].cards.push(cards[:K],cards[8])
          house.hand.cards.push(cards[:K], cards[5])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to_not eq house_original_hand
        end

        it 'hits because less than 17 even if same score as the player' do
          player.hands[0].cards.push(cards[:K],cards[5])
          house.hand.cards.push(cards[:K], cards[5])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to_not eq house_original_hand
        end
        it 'house stands, bigger score than player' do
          player.hands[0].cards.push(cards[:K],cards[8])
          house.hand.cards.push(cards[:A], cards[8])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to eq house_original_hand
        end



        context 'blackjack' do
          it 'house got a blackjack'do
            house.hand.cards.push(cards[:A],cards[:K])
            player.hands[0].cards.push(cards[:K],cards[8])
            game.house_logic
            expect{game.house_logic}.to output{'BLACKJACK!'}.to_stdout
            expect(game.house.hand.best_value).to eq house.hand.soft_hand_value
          end
        end


        context 'busting' do

          it 'Player busts house does nothing' do
            allow(player.hands[0]).to receive(:bust?).and_return(true)
            expect(game.house_logic).to eq nil
          end

          it 'House busts, player wins' do
            allow(house.hand).to receive(:bust?).and_return(true)
            expect{game.house_logic}.to output{"#{house.name} busted, #{player.name} wins\n"}.to_stdout
          end
        end

    end

    describe 'player has more than one hand' do

      before(:each) do
        player.hands.push(Hand.new)
      end

      it 'hits because less than one of the player hands' do
        player.hands[0].cards.push(cards[5],cards[8])
        player.hands[1].cards.push(cards[8],cards[8])
        house.hand.cards.push(cards[5], cards[:K])
        house_original_hand = house.hand.cards.length
        game.house_logic
        expect(house.hand.cards.length).to_not eq house_original_hand
      end

      it 'hits because less than 17' do
        player.hands[0].cards.push(cards[:K],cards[:K])
        player.hands[1].cards.push(cards[:K],cards[5])
        house.hand.cards.push(cards[5], cards[:K])
        house_original_hand = house.hand.cards.length
        game.house_logic
        expect(house.hand.cards.length).to_not eq house_original_hand
      end

      it 'house stands' do
        player.hands[0].cards.push(cards[:K],cards[8])
        player.hands[1].cards.push(cards[:K],cards[5])
        house.hand.cards.push(cards[:A], cards[8])
        house_original_hand = house.hand.cards.length
        game.house_logic
        expect(house.hand.cards.length).to eq house_original_hand
      end

      context 'blackjack' do
        it 'house got a blackjack'do
          house.hand.cards.push(cards[:A],cards[:K])
          player.hands[0].cards.push(cards[:K],cards[8])
          player.hands[1].cards.push(cards[:A],cards[8])
          game.house_logic
          expect{game.house_logic}.to output{'BLACKJACK!'}.to_stdout
          expect(game.house.hand.best_value).to eq house.hand.soft_hand_value
        end
      end

      context 'busting' do

        it 'Player busts on both hands,house does nothing' do
          player.hands[0].cards.push(cards[:K],cards[8], cards[5])
          player.hands[1].cards.push(cards[:K],cards[8], cards[5])
          house.hand.cards.push(cards[:A], cards[8])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to eq house_original_hand
        end

        it 'Player busts on one hand,house plays against player best hand' do
          player.hands[0].cards.push(cards[:K],cards[8], cards[5])
          player.hands[1].cards.push(cards[:K],cards[8])
          house.hand.cards.push(cards[:K], cards[7])
          house_original_hand = house.hand.cards.length
          game.house_logic
          expect(house.hand.cards.length).to_not eq house_original_hand
        end

      end

    end

  end

  context 'bet handling' do

    before(:each) do
      @initial_pbudget = player.budget
      game.bet = 20
    end

    describe 'one hand' do
      context 'player wins' do
        it 'player wins, player hand bigger than house' do
          game.player.hands[0].cards.push(cards[:A],cards[8])
          game.house.hand.cards.push(cards[:K],cards[8])
          game.winner
          expect(player.budget).to eq @initial_pbudget += game.bet
        end

        it 'player won with a blackjack' do
          game.player.hands[0].cards.push(cards[:A],cards[:K])
          game.house.hand.cards.push(cards[:K],cards[8])
          game.winner
          expect(player.budget).to eq @initial_pbudget += (game.bet * 3)/2
        end

        it 'player won with a blackjack the house has a non blackjack 21' do
          game.player.hands[0].cards.push(cards[:A],cards[:K])
          game.house.hand.cards.push(cards[:A],cards[8], cards[2])
          game.winner
          expect(player.budget).to eq @initial_pbudget += (game.bet * 3)/2
        end

        it 'player wins, house busted' do
          game.player.hands[0].cards.push(cards[:A],cards[8])
          game.house.hand.cards.push(cards[:K],cards[8], cards[5])
          game.winner
          expect(player.budget).to eq @initial_pbudget += game.bet
        end
      end

      context 'house wins' do
        it 'house wins, players loses the bet' do
          game.player.hands[0].cards.push(cards[:K],cards[8])
          game.house.hand.cards.push(cards[:A],cards[8])
          game.winner
          expect(player.budget).to eq @initial_pbudget -= game.bet
        end

        it 'house wins, player busted' do
          game.player.hands[0].cards.push(cards[:K],cards[8], cards[5])
          game.house.hand.cards.push(cards[:A],cards[8])
          game.winner
          expect(player.budget).to eq @initial_pbudget -= game.bet
        end

        it 'house wins with blackjack, player has a non blackjack 21' do
          game.player.hands[0].cards.push(cards[:A],cards[8],cards[2])
          game.house.hand.cards.push(cards[:A],cards[:K])
          game.winner
          expect(player.budget).to eq @initial_pbudget -= game.bet
        end
      end
      describe 'tie' do
        it 'tie, bets are null' do
          player.hands[0].cards.push(cards[8],cards[:K])
          house.hand.cards.push(cards[8],cards[:K])
          expect{game.winner}.to output(/Bets are null/).to_stdout
          expect(player.budget).to eq @initial_pbudget
        end
        it 'tie, bets are null. Both player and house have a blackjack' do
          player.hands[0].cards.push(cards[:A],cards[:K])
          house.hand.cards.push(cards[:A],cards[:K])
          expect{game.winner}.to output(/Bets are null/).to_stdout
          expect(player.budget).to eq @initial_pbudget
        end
      end
    end

    describe 'more than one hand' do

      before(:each) do
        player.hands.push(Hand.new)
      end

      it 'player has 2 hands, wins on both. One hand has blackjack. Blackjack not valid with splitting' do
        # player.hands.push(Hand.new)
        player.hands[0].cards.push(cards[:A],cards[:K])
        player.hands[1].cards.push(cards[:A],cards[8])
        house.hand.cards.push(cards[:K],cards[8])
        game.winner
        expect(player.budget).to eq @initial_pbudget + (game.bet * player.hands.length)
      end

      it 'one of the hands is busted' do
        # player.hands.push(Hand.new)
        player.hands[0].cards.push(cards[:A],cards[:K])
        player.hands[1].cards.push(cards[5],cards[8],cards[:K])
        house.hand.cards.push(cards[:K],cards[8])
        game.winner
        expect(player.budget).to eq @initial_pbudget
      end

      it 'one busted and one smaller than the house' do
        # player.hands.push(Hand.new)
        player.hands[0].cards.push(cards[5],cards[:K])
        player.hands[1].cards.push(cards[5],cards[8],cards[:K])
        house.hand.cards.push(cards[:K],cards[8])
        game.winner
        expect(player.budget).to eq @initial_pbudget - (game.bet * 2)
      end

      it 'one hand is a tie the other one is a win ' do
        player.hands[0].cards.push(cards[:A],cards[:K])
        player.hands[1].cards.push(cards[8],cards[:K])
        house.hand.cards.push(cards[:K],cards[8])
        game.winner
        expect(player.budget).to eq @initial_pbudget + game.bet
      end

      it 'one hand is a tie the other one is a loss ' do
        player.hands[0].cards.push(cards[8],cards[:K])
        player.hands[1].cards.push(cards[5],cards[:K])
        house.hand.cards.push(cards[:K],cards[8])
        game.winner
        expect(player.budget).to eq @initial_pbudget - game.bet
      end

      it 'house blackjack, player loses on both hands. One hans non bj 21' do
        player.hands[0].cards.push(cards[8],cards[:K])
        player.hands[1].cards.push(cards[:A],cards[:K])
        house.hand.cards.push(cards[:K],cards[:A])
        game.winner
        expect(player.budget).to eq @initial_pbudget - (game.bet * 2)
      end

    end
  end
  # this test sometimes gets stuck because it gets a double to split
  # context 'main game' do
  #   it 'plays, runs out of budget, then game over'do
  #     allow(player).to receive(:no_budget?).and_return(true)
  #     allow(game).to receive(:gets).and_return('20', 's')
  #     game.play
  #     expect{game.winner}.to output{"#{player.name} run has no budget left, game over"}.to_stdout
  #   end
  # end

end
