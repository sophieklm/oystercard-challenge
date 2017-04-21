require 'journey'


describe Journey do
  subject(:journey) {described_class.new}

  it 'starts a journey' do
    expect(journey).to respond_to(:start_journey).with(1).argument
  end

  it 'has an entry station' do
    journey.start_journey(:bank)
    expect(journey.entry_station).to eq :bank
  end

  it 'has an exit station' do
    journey.end_journey(:waterloo)
    expect(journey.exit_station).to eq :waterloo
  end

  describe '#fare' do
    it 'return the minimum fare' do
      expect(journey.fare).to eq 2
    end
    xit 'return the penalty fare if no exit station' do
      expects
    end
  end

end
