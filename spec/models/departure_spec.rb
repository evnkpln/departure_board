require 'rails_helper'

RSpec.describe Departure, type: :model do
  describe '.chronological' do
    it 'returns departures sorted chronologically' do
      mid_dep = FactoryBot.create(:departure, time: Time.current)
      last_dep = FactoryBot.create(:departure, time: Time.current + 2.hours)
      first_dep = FactoryBot.create(:departure, time: Time.current - 2.hours)

      expect(Departure.chronological.to_a).to eq([first_dep, mid_dep, last_dep])
    end
  end

  describe '.update' do
    let(:adapter) { class_double(Adapter::Mbta) }

    it 'builds from adapter data' do
      departure_params = {
        origin: 'South Station',
        destination: 'Foxboro',
        train_id: 123,
        track_id: 1,
        status: 'Boarding',
        time: nil # TODO: does it make sense to get involved in this?
      }
      allow(adapter).to receive(:call).and_return [departure_params]

      # TODO: Consider returning a collection instead of mutating.
      Departure.update(adapter)

      expect(Departure.last).to have_attributes(departure_params)
    end

    it 'destroys old departures' do
      allow(adapter).to receive(:call).and_return []
      FactoryBot.create(:departure)

      Departure.update(adapter)

      expect(Departure.count).to eq(0)
    end
  end

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
