require 'rails_helper'

RSpec.describe "ForecastFacade" do
  describe "should call the facade and retrieve location results" do
    before(:each) do
      town = "Point Pleasant, NJ"

      @current = ForecastFacade.get_current_forecast(town)
      @hourly = ForecastFacade.get_hourly_forecast(town)
      @daily = ForecastFacade.get_five_day_forecast(town)
      @full_forecast= ForecastFacade.get_all_weather(@current, @hourly, @daily)
    end

    it "gets current forecast" do
      expect(@current.last_updated).to be_a(String)
      expect(@current.temperature).to be_a(Float)
      expect(@current.feels_like).to be_a(Float)
      expect(@current.humidity).to be_a(Integer)
      expect(@current.uvi).to be_a(Float)
      expect(@current.visibility).to be_a(Float)
      expect(@current.condition).to be_a(String)
      expect(@current.icon).to be_a(String)
    end

    it "gets hourly forecast" do
      expect(@hourly.length).to eq(24)

      @hourly.each do |hour|
        expect(hour).to be_a HourlyForecast
      end

      hour = @hourly.first

      expect(hour.time).to be_a(String)
      expect(hour.temperature).to be_a(Float)
      expect(hour.condition).to be_a(String)
      expect(hour.icon).to be_a(String)
    end

    it "gets 5 day forecast" do
      expect(@daily.length).to eq(5)

      @daily.each do |day|
        expect(day).to be_a FiveDayForecast
      end

      day = @daily.first

      expect(day.date).to be_a(String)
      expect(day.sunrise).to be_a(String)
      expect(day.sunset).to be_a(String)
      expect(day.max_temp).to be_a(Float)
      expect(day.min_temp).to be_a(Float)
      expect(day.condition).to be_a(String)
      expect(day.icon).to be_a(String)
    end

    it "gets full forecast" do
      expect(@full_forecast.current).to be_a CurrentWeather

      expect(@full_forecast.forecast).to be_an(Array)
      @full_forecast.forecast.each do |day|
        expect(day).to be_a FiveDayForecast
      end

      expect(@full_forecast.hourly).to be_an(Array)
      @full_forecast.hourly.each do |hour|
        expect(hour).to be_a HourlyForecast
      end

      expect(@full_forecast).to be_a AllWeather
    end
  end
end