require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe "#balance" do
    it "Should return 0 balance" do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it "Expects #top_up to change balance" do
      expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by(10)
    end

    it "Should raise error if top up breaches limit" do
      max_balance = Oystercard::MAXBALANCE
      oystercard.top_up(max_balance)
      expect{ oystercard.top_up(1) }.to raise_error "Top-up over max balance £#{max_balance}"
    end
  end

  describe "#deduct" do
    it "Expects #deduct to change balance" do
      expect { oystercard.deduct(1) }.to change { oystercard.balance }.by(-1)
    end
  end

  describe "#in_journey?" do
    it "Expects #in_journey to return false" do
      expect(oystercard.in_journey?).to eq false
    end
  end

  describe "#touch_in" do
    it "changes #in_journey? to true" do
      expect { oystercard.touch_in }.to change { oystercard.in_journey? }.to true
    end
  end

  describe "#touch_out" do
    it "changes #in_journey to false" do
      oystercard.touch_in
      expect { oystercard.touch_out }.to change { oystercard.in_journey? }.to false
    end
  end

end
