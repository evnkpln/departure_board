require 'rails_helper'

RSpec.describe 'Departures' do
  describe '#index' do
    it 'displays departures' do
      departure = FactoryBot.create(:departure)

      visit root_path # TODO: change to departrues path

      # TODO: update paramters tested against.
      expect(page).to have_content departure.time
    end

    xit 'sorts departures by time'

    xit 'displays dynamic status'

    xit 'pulls data from the API adapter'

    # Bells and whistles
    xit 'separates north/south station departures'

    xit 'updates periodically'

    xit 'updates without refreshing' #can we test this reasonably?
  end
end
