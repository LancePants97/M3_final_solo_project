require 'rails_helper'

RSpec.describe HourlyForecast do
  it "creates a HourlyForecast object with only necessary attributes" do
    json =      
          {
            "time_epoch": 1726977600,
            "time": "2024-09-22 00:00",
            "temp_c": 19.5,
            "temp_f": 67.1,
            "is_day": 0,
            "condition": {
                "text": "Clear ",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                "code": 1000
            },
            "wind_mph": 11.9,
            "wind_kph": 19.1,
            "wind_degree": 55,
            "wind_dir": "NE",
            "pressure_mb": 1014.0,
            "pressure_in": 29.94,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "snow_cm": 0.0,
            "humidity": 75,
            "cloud": 1,
            "feelslike_c": 19.5,
            "feelslike_f": 67.1,
            "windchill_c": 19.5,
            "windchill_f": 67.1,
            "heatindex_c": 19.6,
            "heatindex_f": 67.3,
            "dewpoint_c": 14.8,
            "dewpoint_f": 58.6,
            "will_it_rain": 0,
            "chance_of_rain": 0,
            "will_it_snow": 0,
            "chance_of_snow": 0,
            "vis_km": 10.0,
            "vis_miles": 6.0,
            "gust_mph": 16.7,
            "gust_kph": 26.9,
            "uv": 0
        }

    hour = HourlyForecast.new(json)

    expect(hour).to be_a HourlyForecast

    expect(hour.time).to eq("2024-09-22 00:00")
    expect(hour.temperature).to eq(67.1)
    expect(hour.condition).to eq("Clear ")
    expect(hour.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")
  end
end