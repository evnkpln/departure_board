class Departure < ApplicationRecord
  def formatted_time
    return nil if time.nil?

    time.strftime('%l:%M %p')
  end
end
