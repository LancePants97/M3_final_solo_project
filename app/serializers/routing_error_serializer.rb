class RoutingErrorSerializer
  def self.error_json(origin, destination)
    {
      "data": {
        "id": nil,
        "type": "error",
        "attributes": {
          "start_city": origin,
          "end_city": destination,
          "travel_time": "impossible route",
          "weather_at_eta": {
            "datetime": nil,
            "temperature": nil,
            "condition": nil
          }
        }
      }
    }
  end
end