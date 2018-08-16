require 'ciao'
describe Message do
  subject {Message.new}
  let(:a) {'ciao'}
  it 'changes' do
    subject.cambia(a)
    expect(subject.name).to eq 'ciao'
  end
end
