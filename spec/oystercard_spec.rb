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
        expect{oystercard.top_up(10)}.to change{ oystercard.balance }.by(10)
      end
    end
end

        