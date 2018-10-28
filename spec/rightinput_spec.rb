require 'rightinput'
require 'pry'

describe RightInput do
  it 'input is y' do
    allow(RightInput).to receive(:gets).and_return('y')
    expect(RightInput.yes_or_no).to eq 'y'
  end

  it 'input is n' do
    allow(RightInput).to receive(:gets).and_return('n')
    expect(RightInput.yes_or_no).to eq 'n'
  end

  it 'input is n' do
    allow(RightInput).to receive(:gets).and_return("alb", "n")
    expect(RightInput.yes_or_no).to eq 'n'
  end

end
