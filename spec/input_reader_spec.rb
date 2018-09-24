require 'input_reader'
require 'player'


describe InputReader do
    context 'receiving the right inputs' do

        #the following lines stops the console
        before(:each) do
            allow($stdout).to receive(:write)
        end

        let(:player) {Player.new(budget: 5000)}
        subject {InputReader.new} 


        it 'receives a name input' do
            original_name = subject.p_name
            allow(subject).to receive(:gets).and_return("Brian\n")
            subject.name_input
            expect(subject.p_name).to_not eq original_name
        end

        it 'does not receive a name input' do
            allow(subject).to receive(:gets).and_return("\n")
            subject.name_input
            expect(subject.p_name).to eq "Player"
        end

        it 'does not receive a name input' do
            allow(subject).to receive(:gets).and_return("\n")
            subject.name_input
            expect(subject.p_name).to eq "Player"
        end

        it 'accepts only the correct budget input' do
            allow(subject).to receive(:gets).and_return("ciao\n", "200\n", "5000\n")
            subject.budget_input
            expect(subject.p_budget).to eq 5000
        end

        it 'it accepts only the right bet: Integer and less than player budget' do
            allow(subject).to receive(:gets).and_return("ciao\n", "6000\n", "20\n")
            subject.bet_input(player)
            expect(subject.bet_in).to eq 20
        end

        it 'accepts only the correct deck input' do
            allow(subject).to receive(:gets).and_return("ciao\n", "3\n","9\n", "2\n")
            subject.decks_input
            expect(subject.n_deck).to eq 2
        end
    end

    context 'seting up' do
        it 'set up the parameters accordingly to the inputs' do
            allow(subject).to receive(:gets).and_return("foo\n", "200\n", "5000\n", "16\n", "2\n")
            subject.set_up
            expect(subject.p_name).to eq "foo"
            expect(subject.p_budget).to eq 5000
            expect(subject.n_deck).to eq 2
        end
    
    end
end