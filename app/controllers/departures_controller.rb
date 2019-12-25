class DeparturesController < ApplicationController
  def index
    @departures = Departure.all
  end
end
