require 'station'

describe Station do
	describe '#new' do
		subject { Station.new(:waterloo, 2) }
		it 'takes 2 arguments' do
			expect(Station).to respond_to(:new).with(2).arguments
		end
		it 'should store zone arguments in @zone' do
			expect(subject.name).to eq :waterloo
		end
		it 'should store name arguments in @name' do
			expect(subject.zone).to eq 2
		end
	end
end
