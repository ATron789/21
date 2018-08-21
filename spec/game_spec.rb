require 'game'

describe Game do
  # before(:each) do
  #   allow($stdout).to receive(:write)
  # end
  let(:player) {Player.new('pippo', [], 200)}
  let(:house) {House.new}

  subject {Game.new(player, house,100)}

  it 'has a bet input' do
    # allow(subject).to receive(:gets).and_return("200\n")
    subject.lets_play
    expect(subject.house.name).to eq 'House'
  end
end
