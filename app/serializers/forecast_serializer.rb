class ForecastSerializer
  def self.weather_json(weather)
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "last_updated": weather.current.last_updated,
            "temperature": weather.current.temperature,
            "feels_like": weather.current.feels_like,
            "humidity": weather.current.humidity,
            "uvi": weather.current.uvi,
            "visibility": weather.current.visibility,
            "condition": weather.current.condition,
            "icon": weather.current.icon
          },

          "daily_weather": weather.forecast.map do |day|
            daily_forecast_json(day)
          end,

          "hourly_weather": weather.hourly.map do |hour|
            hourly_forecast_json(hour)
          end
        }
      }
    }
  end

  def self.hourly_forecast_json(hour)
    {
      "time": hour.time,
      "temperature": hour.temperature,
      "conditions": hour.condition,
      "icon": hour.icon
    }
  end

  def self.daily_forecast_json(day)
    {
      "date": day.date,
      "sunrise": day.sunrise,
      "sunset": day.sunset,
      "max_temp": day.max_temp,
      "min_temp": day.min_temp,
      "condition": day.condition,
      "icon": day.icon
    }
  end
end