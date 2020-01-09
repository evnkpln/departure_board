require 'rails_helper'

# TODO: RSpec.feature is giving access to view and path helpers, but this is
# not the conventional usage of it.
RSpec.feature 'Departures' do
  describe '#index' do
    it 'displays departures' do
      departure = FactoryBot.create(:departure, basic_departure_params)

      visit departures_path

      expect(page).to have_content departure.destination
      expect(page).to have_content departure.train_id
      expect(page).to have_content departure.track_id
      expect(page).to have_content departure.status
    end

    it 'displays times in HH:MM format' do
      FactoryBot.create(:departure, time: '12:30 PM')

      visit departures_path

      expect(page).to have_content '12:30 PM'
    end

    it 'sorts departures by time' do
      FactoryBot.create(:departure, train_id: 2222, time: Time.current)
      FactoryBot.create(:departure, train_id: 1111,
                                    time: Time.current - 2.hours)
      FactoryBot.create(:departure, train_id: 3333,
                                    time: Time.current + 2.hours)

      visit departures_path

      first_dep_index = page.body.index('1111')
      middle_dep_index = page.body.index('2222')
      last_dep_index = page.body.index('3333')
      expect(first_dep_index).to be < middle_dep_index
      expect(middle_dep_index).to be < last_dep_index
    end

    xit 'displays dynamic status'

    xit 'pulls data from the API adapter'

    xit 'separates north/south station departures'

    # Stretch goals
    xit 'updates periodically'

    xit 'updates without refreshing' # can we test this reasonably?

    # Low priority since it's all local, but you never know. . .
    xit 'handles time zones'
  end

  def basic_departure_params
    {
      destination: 'Foxboro',
      train_id: 1234,
      track_id: 5678,
      status: 'On Time'
    }
  end
end
