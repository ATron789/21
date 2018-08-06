require 'bet'
describe Bet do
  it 'accepts an amount to bet' do
    expect(Bet.new(200).amount).to eq 200
  end
end
