require 'ciao'
describe Message do
  subject {Message.new}
  let(:a) {'ciao'}
  it 'changes' do
    expect {subject.cambia()}.to raise_error(ArgumentError)
  end
end
