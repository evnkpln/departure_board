class DeparturesController < ApplicationController
  def index
    response = Adapter::Mbta.predictions
    @departures = Departure.build_from_api(response)
      .sort { |a, b| a.time <=> b.time }
    # @departures = Departure.chronological
  end
end
