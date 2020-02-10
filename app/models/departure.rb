class Departure < ApplicationRecord
  # TODO: This scope is currently unused since we're not hitting the database.
  # Consider removing it.
  scope :chronological, -> { order(time: :asc) }

  # Beware. This destroys all records. Should be updated to something less
  # brittle soon.
  def self.update(adapter)
    param_array = adapter.call
    destroy_all
    param_array.each do |params|
      create(params)
    end
  end

  def self.build_from_api(response)
    departures = []
    response.each do |data|
      params = {
        status: data[:status],
        time: data[:scheduled_time],
        destination: data[:destination],
        train_id: data[:train_id],
        track_id: data[:track]
      }
      departures << new(params)
    end
    departures
  end

  def formatted_time
    return nil if time.nil?

    time.strftime('%l:%M %p')
  end
end
