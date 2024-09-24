class RoadTripFacade
  def self.get_road_trip(origin, destination)
    directions = CoordinatesService.get_road_trip(origin, destination)
    if directions[:routeError]
      { "error": "impossible route" }
    else
      road_trip = RoadTrip.new(directions)
      weather = ForecastService.find_travel_forecast(destination)
      day = road_trip.travel_days + 1 # use for weather json :forecastday array
      hour_of_arrival = road_trip.eta_hour # use for weather json :hour array

      arrival_weather_json = weather[:forecast][:forecastday][day][:hour][hour_of_arrival]
      arrival_weather = HourlyForecast.new(arrival_weather_json)

      road_trip_weather = { road_trip: road_trip, forecast: arrival_weather}
      road_trip_weather
    end
  end
end