require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
    describe "#balance" do
      it "should return 0 balance" do
        expect(oystercard.balance).to eq(0)
      end
    end
end

        