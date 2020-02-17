class DeparturesController < ApplicationController
  def index
    # TODO: Departure model should probably be responsible for managing the
    # adapter.
    response = Adapter::Mbta.predictions
    departures = Departure.build_from_api(response)
      .sort { |a, b| a.time <=> b.time }
    @south_station_departures = departures.select do |departure|
      departure.origin == 'South Station'
    end
    @north_station_departures = departures.select do |departure|
      departure.origin == 'North Station'
    end
  end
end
