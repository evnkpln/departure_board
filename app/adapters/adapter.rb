module Adapter
  class Mbta
    include HTTParty
    ENDPOINT_URL = 'https://api-v3.mbta.com'.freeze
    SCHEDULES_URL = "#{ENDPOINT_URL}/schedules".freeze
    PREDICTIONS_URL = "#{ENDPOINT_URL}/predictions".freeze
    SOUTH_STATION_CODE = 'place-sstat'.freeze
    NORTH_STATION_CODE = 'place-north'.freeze

    def self.predictions
      parse_response(raw_predictions)
    end

    def self.parse_response(response)
      parsed_json = JSON.parse(response.body)
      data = parsed_json['data']
      included = parsed_json['included']

      output = data.map do |prediction|
        dep_hash = {
          status: prediction['attributes']['status'],
          predicted_time: prediction['attributes']['departure_time']
        }
        # TODO: Extract method: add scheduled_tim e
        schedule_id = prediction['relationships']['schedule']['data']['id']
        schedule = included.find do |elem|
          elem['id'] == schedule_id
        end
        dep_hash.merge!(scheduled_time: schedule['attributes']['departure_time'])
        # TODO: Extract method: add trip data
        trip_id = prediction['relationships']['trip']['data']['id']
        trip = included.find do |elem|
          elem['id'] == trip_id
        end
        dep_hash.merge!(
          destination: trip['attributes']['headsign'],
          train_id: trip['attributes']['name']
        )
        # TODO: Extract method: add stop data
        stop_id = prediction['relationships']['stop']['data']['id']
        stop = included.find do |elem|
          elem['id'] == stop_id
        end
        track = stop['attributes']['platform_code']# || 'TBD'
        dep_hash.merge!(
          track: track,
          origin: clip_track_id(stop_id)
        )
      end
      output
    end

    def self.raw_predictions
      get(PREDICTIONS_URL, query: predictions_query)
    end

    def self.predictions_query
      n_s_stations.merge(commuter_rail).merge(outbound).merge(include_schedule)
    end

    def self.schedules
      get(SCHEDULES_URL, query: query)
    end

    def self.outbound
      { 'filter[direction_id]': 0 }
    end

    def self.include_schedule
      { include: 'schedule,trip,stop' }
    end

    def self.commuter_rail
      { 'filter[route_type]': 2 }
    end

    def self.next_two_hours
      filter_min = Time.current - 5.minutes
      filter_max = Time.current + 2.hours + 5.minutes

      {
        'filter[min_time]': filter_min.strftime('%H:%M'),
        'filter[max_time]': filter_max.strftime('%H:%M')
      }
    end

    def self.n_s_stations
      { 'filter[stop]': "#{SOUTH_STATION_CODE},#{NORTH_STATION_CODE}" }
    end

    def self.endpoint
      ENDPOINT_URL
    end

    private

    # clip track_ids off of stop id for origin
    def self.clip_track_id(stop_id)
      stop_id.sub(/\-(.*)/, '')
    end
  end
end
