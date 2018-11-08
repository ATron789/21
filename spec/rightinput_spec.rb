require 'rightinput'
require 'pry'

describe RightInput do
  context 'yes or no' do
    it 'input is y' do
      allow(RightInput).to receive(:gets).and_return('y')
      expect(RightInput.yes_or_no).to eq 'y'
    end

    it 'input is n' do
      allow(RightInput).to receive(:gets).and_return('n')
      expect(RightInput.yes_or_no).to eq 'n'
    end

    it 'input first input wrong then right one' do
      allow(RightInput).to receive(:gets).and_return("alb", "n")
      expect(RightInput.yes_or_no).to eq 'n'
    end
  end

  context 'hit or stand' do
    it 'input is h' do
      allow(RightInput).to receive(:gets).and_return('h')
      expect(RightInput.hit_stand).to eq 'h'
    end
    it 'input is s' do
      allow(RightInput).to receive(:gets).and_return('s')
      expect(RightInput.hit_stand).to eq 's'
    end
    it 'input first input wrong then right one' do
      allow(RightInput).to receive(:gets).and_return('foo','s')
      expect(RightInput.hit_stand).to eq 's'
    end

  end


end
