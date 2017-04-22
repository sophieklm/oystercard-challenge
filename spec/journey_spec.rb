require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

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
      journey.start_journey(:station)
      journey.end_journey(:station)
      expect(journey.fare).to eq Journey::MIN_FARE
    end
    it 'return the penalty fare if no exit station' do
      journey.start_journey(:station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
    it 'return the penalty far if no entry station' do
      journey.end_journey(:station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe '#journey_complete?' do
    it 'returns true if entry and exit station exist' do
      journey.start_journey(:station)
      journey.end_journey(:station)
      expect(journey.journey_complete?).to be true
    end
    it 'returns false if entry station nil' do
      journey.start_journey(:station)
      expect(journey.journey_complete?).to be false
    end
    it 'returns false if entry station nil' do
      journey.end_journey(:station)
      expect(journey.journey_complete?).to be false
    end
  end
end
