require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

    describe "#balance" do
      it "should return 0 balance" do
        expect(oystercard.balance).to eq(0)
      end
    end

    describe "#top_up" do
      it "Expects #top_up to change balance" do
        expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by(10)
      end

      it "should raise error if top up breaches limit" do
        max_balance = Oystercard::MAXBALANCE
        oystercard.top_up(max_balance)
        expect{ oystercard.top_up(1) }.to raise_error "Top-up is over maximum balance #{max_balance}"
      end
    end
end
