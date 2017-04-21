require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'Should return 0 balance' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'Expects #top_up to change balance' do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it 'Should raise error if top up breaches limit' do
      max_balance = Oystercard::MAX_BALANCE
      oystercard.top_up(max_balance)
      expect { oystercard.top_up(1) }.to raise_error "Top-up over max balance £#{max_balance}"
    end
  end

  describe '#in_journey?' do
    it 'Expects #in_journey to return false' do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe '#touch_in(entry_station)' do
    let(:station){ double :station }
    subject(:oystercard) { described_class.new }
    before(:each) { oystercard.top_up(20) }
    it 'changes #in_journey? to true' do
      expect { oystercard.touch_in(:station) }.to change { oystercard.in_journey? }.to true
    end
    it '#touch_in(entry_station) when already travelling raises error' do
      oystercard.touch_in(:station)
      expect { oystercard.touch_in(:station) }.to raise_error 'Already travelling'
    end
      context 'low_balance' do
        it 'Raises an error' do
          low_balance = Oystercard::LOW_BALANCE
          oystercard.top_up(low_balance - 21)
          expect { oystercard.touch_in(:station) }.to raise_error 'Not enough funds'
        end
      end
    it 'updates @entry with the current station' do
      oystercard.touch_in(:station)
      expect(oystercard.entry).to eq :station
    end
    it 'starts a new journey' do
      expect { oystercard.touch_in(:station) }.to change { oystercard.current_journey }.to be_truthy
    end
  end

  describe '#current_journey' do
    it 'will be nil before we touch in' do
      expect(Oystercard.new.current_journey).to be_nil
    end
  end


  describe '#touch_out(exit_station)' do
    let(:station){ double :station }
    before(:each){ oystercard.top_up(10) }
    it 'takes one argument' do
      expect(oystercard).to respond_to(:touch_out).with(1).argument
    end
    it 'changes #in_journey to false' do
      oystercard.touch_in(:station)
      expect { oystercard.touch_out(:station) }.to change { oystercard.in_journey? }.to false
    end
    it 'raises error if touch_out when not in journey' do
      expect { oystercard.touch_out(:station) }.to raise_error 'ERROR! Not travelling!'
    end
    it 'sets #entry to nil' do
      oystercard.touch_in(:station)
      expect { oystercard.touch_out(:station) }.to change { oystercard.entry }.to nil
    end
    it 'updates @journeys with hash of entry and exit stations'do
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard.journeys.last).to include({:entry => :station, :exit => :station})
    end

      context "change balance" do
        it "deducts fare" do
          oystercard.top_up(20)
          oystercard.touch_in(:station)
          expect { oystercard.touch_out(:station) }.to change {oystercard.balance }.by -Oystercard::FARE
        end
      end
    end
  describe '#journeys' do
    it 'card has an empty list of journeys by default' do
      expect(oystercard.journeys).to be_empty
    end
  end
  end
