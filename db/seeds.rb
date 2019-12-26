# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

Departure.create(origin: 'South Station', destination: 'Foxboro', train_id: 623, track_id: 0, status: 'On Time', time: Time.local(2019,12,26,20,30))
Departure.create(origin: 'South Station', destination: 'Test AA', train_id: 222, track_id: 0, status: '5 min delayed', time: Time.local(2019,12,27,0,12))
Departure.create(origin: 'South Station', destination: 'Test BB', train_id: 903, track_id: 2, status: 'Boarding', time: Time.local(2019,12,26,19,0))
