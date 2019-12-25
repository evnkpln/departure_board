require 'rails_helper'

RSpec.describe Departure, type: :model do
  describe '#formatted_time' do
    it 'displays time in HH:MM A/PM format' do
      departure = FactoryBot.build(:departure, time: '12:30 PM')
      expect(departure.formatted_time).to eq('12:30 PM')
    end

    it 'returns nil if time is nil' do
      departure = FactoryBot.build(:departure, time: nil)
      expect(departure.formatted_time).to eq(nil)
    end
  end
end
