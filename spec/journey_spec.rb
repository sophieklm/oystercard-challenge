require 'journey'


describe Journey do
  subject {described_class.new(:bank)}
  it 'has 1 argument' do
    expect(Journey).to respond_to(:new).with(1).argument
  end

  it 'starts a journey' do
    expect(subject).to respond_to(:start_journey).with(1).argument
  end

  it 'has an entry station' do
    expect(subject.entry_station).to eq :bank
  end

  xit 'has an exit station' do
    expect(subject.exit_station).to eq :bank
  end

end
