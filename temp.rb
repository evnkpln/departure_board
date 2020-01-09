load 'app/adapters/adapter.rb'
response = Adapter::Mbta.predictions
parsed = JSON.parse(response.body)
data = parsed['data']
included = parsed['included']

output = data.map do |prediction|
  dep_hash = {
    status: prediction['attributes']['status'],
    predicted_time: prediction['attributes']['departure_time']
  }
  schedule_id = prediction['relationships']['schedule']['data']['id']
  schedule = included.find do |elem|
    elem['id'] == schedule_id
  end
  dep_hash.merge!(scheduled_time: schedule['attributes']['departure_time'])
  trip_id = prediction['relationships']['trip']['data']['id']
  trip = included.find do |elem|
    elem['id'] == trip_id
  end
  dep_hash.merge!(
    destination: trip['attributes']['headsign'],
    train_id: trip['attributes']['name']
  )
  stop_id = prediction['relationships']['stop']['data']['id']
  stop = included.find do |elem|
    elem['id'] == stop_id
  end
  track = stop['attributes']['platform_code']# || 'TBD'
  dep_hash.merge(
    track: track
  )
end
