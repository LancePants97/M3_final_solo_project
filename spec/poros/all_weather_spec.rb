require 'rails_helper'

RSpec.describe AllWeather do
  it "creates a FiveDayForecast object with only necessary attributes" do
    town = "Point Pleasant, NJ"
    current = ForecastFacade.get_current_forecast(town)
    hourly = ForecastFacade.get_hourly_forecast(town)
    daily = ForecastFacade.get_five_day_forecast(town)
    full_forecast= ForecastFacade.get_all_weather(current, hourly, daily)

    data = ForecastFacade.get_all_weather(current, hourly, daily)

    expect(data.current.last_updated).to be_a(String)
    expect(data.current.temperature).to be_a(Float)
    expect(data.current.feels_like).to be_a(Float)
    expect(data.current.humidity).to be_a(Integer)
    expect(data.current.uvi).to be_a(Float)
    expect(data.current.visibility).to be_a(Float)
    expect(data.current.condition).to be_a(String)
    expect(data.current.icon).to be_a(String)

    expect(data.hourly.length).to eq(24)

    data.hourly.each do |hour|
      expect(hour).to be_a HourlyForecast
      expect(hour.condition).to be_a(String)
      expect(hour.icon).to be_a(String)
      expect(hour.time).to be_a(String)
      expect(hour.temperature).to be_a(Float)
    end

    expect(data.forecast.length).to eq(5)

    data.forecast.each do |day|
      expect(day).to be_a FiveDayForecast
      expect(day.condition).to be_a(String)
      expect(day.date).to be_a(String)
      expect(day.icon).to be_a(String)
      expect(day.max_temp).to be_a(Float)
      expect(day.min_temp).to be_a(Float)
      expect(day.sunrise).to be_a(String)
      expect(day.sunset).to be_a(String)
    end
  end
end