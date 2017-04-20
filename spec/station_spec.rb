require 'station'

describe Station do

	describe '#new' do
		it 'takes 2 arguments' do
			expect(Station).to respond_to(:initialize).with(2).arguments
		end
	end
end

