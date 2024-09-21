class ForecastFacade
  # def self.get_current_weather(town)
  #   coordinates = CoordinatesFacade.get_lat_lon(town)
  #   data = ForecastService.find_forecast(coordinates)
  #   # CurrentWeather.new(data)
  # end

  # def self.get_hourly_forecast(town)
  #   coordinates = CoordinatesFacade.get_lat_lon(town)
  #   data = ForecastService.find_forecast(coordinates)
  #   # binding.pry
  #   # HourlyForecast.new(data)
  # end

  def self.get_five_day_forecast(town)
    coordinates = CoordinatesFacade.get_lat_lon(town)
    data = ForecastService.find_forecast(coordinates)
    
    data[:forecast][:forecastday].map do |weather_attrs|
      binding.pry
      
      FiveDayForecast.new(weather_attrs)
    end
  end

  # def self.get_all_weather(current, hourly, forecast)
  #   AllWeather.new(current, hourly, forecast)
  # end

end