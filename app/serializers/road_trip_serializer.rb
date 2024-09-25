class RoadTripSerializer
  def self.road_trip_json(road_trip, origin, destination)
    {
      "data": {
        "id": nil,
        "type": "road_trip",
        "attributes": {
          "start_city": origin,
          "end_city": destination,
          "travel_time": format_time(road_trip[:road_trip].travel_time),
          "weather_at_eta": {
            "datetime": road_trip[:forecast].time,
            "temperature": road_trip[:forecast].temperature,
            "condition": road_trip[:forecast].condition
          }
        }
      }
    }
  end

  def self.format_time(time)
    hours = time.split(':')[0]
    minutes = time.split(':')[1]
    "#{hours} hours, #{minutes} minutes"
  end
end