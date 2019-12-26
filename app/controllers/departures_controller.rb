class DeparturesController < ApplicationController
  def index
    @departures = Departure.chronological
  end
end
