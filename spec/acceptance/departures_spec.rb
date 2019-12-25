require 'rails_helper'

# TODO: RSpec.feature is giving access to view and path helpers, but this is
# not the conventional usage of it.
RSpec.feature 'Departures' do
  describe '#index' do
    it 'displays departures' do
      departure = FactoryBot.create(:departure, basic_departure_params)

      visit departures_path

      # TODO: Too many expectations. Group or break up.
      expect(page).to have_content departure.destination
      expect(page).to have_content departure.train_id
      expect(page).to have_content departure.track_id
      expect(page).to have_content departure.status
      expect(page).to have_content departure.time # TODO: Formatting
    end

    xit 'sorts departures by time'

    # Maybe leave this one to unit test or wrap into sort spec.
    xit 'properly sorts across multiple dates'

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
      status: 'On Time',
      time: Time.current
    }
  end
end
