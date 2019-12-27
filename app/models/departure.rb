class Departure < ApplicationRecord
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

  def formatted_time
    return nil if time.nil?

    time.strftime('%l:%M %p')
  end
end
