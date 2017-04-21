require 'journey'


describe Journey do
  subject {described_class.new}

  it 'starts a journey' do
    expect(subject).to respond_to(:start_journey).with(1).argument
  end

  it 'has an entry station' do
    subject.start_journey(:bank)
    expect(subject.entry_station).to eq :bank
  end

  it 'has an exit station' do
    subject.end_journey(:waterloo)
    expect(subject.exit_station).to eq :waterloo
  end

end
