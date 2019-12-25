class AddTimeToDepartures < ActiveRecord::Migration[6.0]
  def change
    add_column :departures, :time, :datetime
  end
end
