require 'rails_helper'

RSpec.describe FiveDayForecast do
  it "creates a FiveDayForecast object with only necessary attributes" do
    json = {
            "date": "2024-09-22",
            "date_epoch": 1726963200,
            "day": {
                "maxtemp_c": 24.7,
                "maxtemp_f": 76.5,
                "mintemp_c": 17.6,
                "mintemp_f": 63.7,
                "avgtemp_c": 20.5,
                "avgtemp_f": 69.0,
                "maxwind_mph": 13.9,
                "maxwind_kph": 22.3,
                "totalprecip_mm": 0.0,
                "totalprecip_in": 0.0,
                "totalsnow_cm": 0.0,
                "avgvis_km": 10.0,
                "avgvis_miles": 6.0,
                "avghumidity": 70,
                "daily_will_it_rain": 0,
                "daily_chance_of_rain": 0,
                "daily_will_it_snow": 0,
                "daily_chance_of_snow": 0,
                "condition": {
                    "text": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    "code": 1000
                },
                "uv": 3.0
            },
            "astro": {
                "sunrise": "06:44 AM",
                "sunset": "06:52 PM",
                "moonrise": "09:34 PM",
                "moonset": "12:23 PM",
                "moon_phase": "Waning Gibbous",
                "moon_illumination": 79,
                "is_moon_up": 0,
                "is_sun_up": 0
              }
            }

    day = FiveDayForecast.new(json)

    expect(day).to be_a FiveDayForecast
    
    expect(day.date).to eq("2024-09-22")
    expect(day.sunrise).to eq("06:44 AM")
    expect(day.sunset).to eq("06:52 PM")
    expect(day.max_temp).to eq(76.5)
    expect(day.min_temp).to eq(63.7)
    expect(day.condition).to eq("Sunny")
    expect(day.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/113.png")
  end
end