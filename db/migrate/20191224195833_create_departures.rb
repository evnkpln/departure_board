class CreateDepartures < ActiveRecord::Migration[6.0]
  def change
    create_table :departures do |t|
      t.string :origin
      t.string :destination
      t.integer :train_id
      t.integer :track_id
      t.string :status

      t.timestamps
    end
  end
end
