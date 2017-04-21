require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station){ double :station }

  max_balance = Oystercard::MAX_BALANCE
  min_fare = Journey::MIN_FARE
  penalty_fare = Journey::PENALTY_FARE

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
    subject(:oystercard) { described_class.new }
    before(:each) { oystercard.top_up(max_balance) }
    it 'changes #in_journey? to true' do
      expect { oystercard.touch_in(:station) }.to change { oystercard.in_journey? }.to true
    end
    it '#touch_in(entry_station) when already travelling charges penalty' do
      oystercard.touch_in(:station)
      expect { oystercard.touch_in(:station) }.to change{oystercard.balance}.by -Journey::PENALTY_FARE
    end
      context 'low_balance' do
        it 'Raises an error' do
          oystercard.top_up(-max_balance)
          expect { oystercard.touch_in(:station) }.to raise_error 'Not enough funds'
        end
      end
    it 'starts a new journey' do
      expect { oystercard.touch_in(:station) }.to change { oystercard.current_journey }.to be_truthy
    end
  end

  describe '#current_journey' do
    it 'will be nil before we touch in' do
      expect(subject.current_journey).to be_nil
    end
  end


  describe '#touch_out(exit_station)' do
    before(:each) do
      oystercard.top_up(max_balance)
      oystercard.touch_in(:station)
    end
    it 'takes one argument' do
      expect(oystercard).to respond_to(:touch_out).with(1).argument
    end
    it 'changes #in_journey to false' do
      expect { oystercard.touch_out(:station) }.to change { oystercard.in_journey? }.to false
    end
    it 'charges penalty if touch_out when not in journey' do
      oystercard.touch_out(:station)
      expect { oystercard.touch_out(:station) }.to change{oystercard.balance}.by -penalty_fare + min_fare
    end
    it 'updates @journeys with current_journey'do
      oystercard.touch_out(:exit_station)
      expect(oystercard.journeys).to include(oystercard.current_journey)
    end
      context "change balance" do
        it "deducts fare" do
          expect { oystercard.touch_out(:station) }.to change {oystercard.balance }.by -min_fare
        end
      end
    end

  describe '#journeys' do
    it 'card has an empty list of journeys by default' do
      expect(oystercard.journeys).to be_empty
    end
  end
  end
