class ForecastFacade
  def self.get_current_forecast(town)
    coordinates = CoordinatesFacade.get_lat_lon(town)
    data = ForecastService.find_forecast(coordinates)

    current_data = data[:current]
    CurrentWeather.new(current_data)
  end

  def self.get_hourly_forecast(town)
    coordinates = CoordinatesFacade.get_lat_lon(town)
    data = ForecastService.find_forecast(coordinates)
    
    data[:forecast][:forecastday][0][:hour].map do |hour|
      HourlyForecast.new(hour)
    end
  end

  def self.get_five_day_forecast(town)
    coordinates = CoordinatesFacade.get_lat_lon(town)
    data = ForecastService.find_forecast(coordinates)

    data[:forecast][:forecastday].map do |weather_attrs|
      FiveDayForecast.new(weather_attrs)
    end
  end

  def self.get_all_weather(current, hourly, forecast)
    AllWeather.new(current, hourly, forecast)
  end
end