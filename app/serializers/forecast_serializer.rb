class ForecastSerializer
  def self.weather_json(weather_forecast)
    {
      "data": weather_forecast.map do |weather|
        binding.pry
        {
          "id": null,
          "type": "forecast",
          "attributes": {
            "current_weather": {
              "last_updated": "2023-04-07 16:30",
              "temperature": 55.0
              
            },
            "daily_weather": [
              {
                "date": "2023-04-07",
                "sunrise": "07:13 AM"
                
              },
              {"code"}
            ],
            "hourly_weather": [
              {
                "time": "14:00",
                "temperature": 54.5
                
              },
              {"code"} 
            ]
          }
        }
      end
    }
  end
end