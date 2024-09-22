require 'rails_helper'

RSpec.describe CurrentWeather do
  it "creates a CurrentWeather object with only necessary attributes" do
    json = {
            "last_updated_epoch": 1727046000,
            "last_updated": "2024-09-22 19:00",
            "temp_c": 19.4,
            "temp_f": 66.9,
            "is_day": 0,
            "condition": {
                "text": "Clear",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                "code": 1000
            },
            "wind_mph": 10.1,
            "wind_kph": 16.2,
            "wind_degree": 86,
            "wind_dir": "E",
            "pressure_mb": 1017.0,
            "pressure_in": 30.03,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 71,
            "cloud": 0,
            "feelslike_c": 19.4,
            "feelslike_f": 66.9,
            "windchill_c": 21.9,
            "windchill_f": 71.5,
            "heatindex_c": 22.7,
            "heatindex_f": 72.9,
            "dewpoint_c": 16.2,
            "dewpoint_f": 61.1,
            "vis_km": 16.0,
            "vis_miles": 9.0,
            "uv": 1.0,
            "gust_mph": 14.0,
            "gust_kph": 22.5
          }
            
    current_weather = CurrentWeather.new(json)

    expect(current_weather).to be_a CurrentWeather

    expect(current_weather.last_updated).to eq("2024-09-22 19:00")
    expect(current_weather.temperature).to eq(66.9)
    expect(current_weather.feels_like).to eq(66.9)
    expect(current_weather.humidity).to eq(71)
    expect(current_weather.uvi).to eq(1.0)
    expect(current_weather.visibility).to eq(9.0)
    expect(current_weather.condition).to eq("Clear")
    expect(current_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")
  end
end