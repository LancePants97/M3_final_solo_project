require 'rails_helper'

RSpec.describe 'Weather Forecast Request', type: :request do
  before(:each) do
    base_url = "http://api.weatherapi.com"

    json_response = File.read('spec/fixtures/weather_json.json')
    api_key = Rails.application.credentials.weather[:key]
    location = "Point Pleasant, NJ"
    coordinates = CoordinatesFacade.get_lat_lon(location)

    stub_request(:get, "#{base_url}/v1/forecast.json?key=#{api_key}&q=#{coordinates}&days=5")
      .to_return(status: 200, body: json_response, headers: { 'Content-Type' => 'application/json' } )
    
    get "/api/v1/forecast", params: { location: location }

    @forecast = JSON.parse(response.body, symbolize_names: true)[:data]
  end
  
  it 'returns a formatted current weather JSON when given a location' do
    expect(@forecast[:id]).to eq(nil)
    expect(@forecast[:type]).to eq("forecast")
    
    current = @forecast[:attributes][:current_weather]

    expect(current).to have_key(:last_updated)
    expect(current[:last_updated]).to eq("2024-09-22 19:00")

    expect(current).to have_key(:temperature)
    expect(current[:temperature]).to eq(66.9)

    expect(current).to have_key(:feels_like)
    expect(current[:feels_like]).to eq(66.9)

    expect(current).to have_key(:humidity)
    expect(current[:humidity]).to eq(71)

    expect(current).to have_key(:uvi)
    expect(current[:uvi]).to eq(1.0)

    expect(current).to have_key(:visibility)
    expect(current[:visibility]).to eq(9.0)

    expect(current).to have_key(:condition)
    expect(current[:condition]).to eq("Clear")

    expect(current).to have_key(:icon)
    expect(current[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")

    expect(current).to_not have_key(:last_updated_epoch)
    expect(current).to_not have_key(:temp_c)
    expect(current).to_not have_key(:is_day)
    expect(current).to_not have_key(:wind_mph)
    expect(current).to_not have_key(:wind_kph)
    expect(current).to_not have_key(:wind_degree)
    expect(current).to_not have_key(:wind_dir)
    expect(current).to_not have_key(:pressure_mb)
    expect(current).to_not have_key(:pressure_in)
    expect(current).to_not have_key(:precip_mm)
    expect(current).to_not have_key(:precip_in)
    expect(current).to_not have_key(:cloud)
    expect(current).to_not have_key(:feelslike_c)
    expect(current).to_not have_key(:feelslike_f)
    expect(current).to_not have_key(:windchill_c)
    expect(current).to_not have_key(:windchill_f)
    expect(current).to_not have_key(:heatindex_c)
    expect(current).to_not have_key(:heatindex_f)
    expect(current).to_not have_key(:vis_km)
    expect(current).to_not have_key(:gust_mph)
    expect(current).to_not have_key(:gust_kph)
  end

  it 'returns a formatted hourly weather JSON when given a location' do
    hourly = @forecast[:attributes][:hourly_weather]

    expect(hourly.length).to eq(24)

    hour = hourly.first

    expect(hour).to have_key(:time)
    expect(hour[:time]).to eq("2024-09-22 00:00")

    expect(hour).to have_key(:temperature)
    expect(hour[:temperature]).to eq(67.1)

    expect(hour).to have_key(:conditions)
    expect(hour[:conditions]).to eq("Clear ")

    expect(hour).to have_key(:icon)
    expect(hour[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")

    hourly.each do |hour|
      expect(hour).to have_key(:time)
      expect(hour).to have_key(:temperature)
      expect(hour).to have_key(:conditions)
      expect(hour).to have_key(:icon)

      expect(hour).to_not have_key(:time_epoch)
      expect(hour).to_not have_key(:temp_c)
      expect(hour).to_not have_key(:is_day)
      expect(hour).to_not have_key(:wind_mph)
      expect(hour).to_not have_key(:wind_kph)
      expect(hour).to_not have_key(:wind_degree)
      expect(hour).to_not have_key(:wind_dir)
      expect(hour).to_not have_key(:pressure_mb)
      expect(hour).to_not have_key(:pressure_in)
      expect(hour).to_not have_key(:precip_mm)
      expect(hour).to_not have_key(:precip_in)
      expect(hour).to_not have_key(:snow_cm)
      expect(hour).to_not have_key(:cloud)
      expect(hour).to_not have_key(:feelslike_c)
      expect(hour).to_not have_key(:feelslike_f)
      expect(hour).to_not have_key(:windchill_c)
      expect(hour).to_not have_key(:windchill_f)
      expect(hour).to_not have_key(:heatindex_c)
      expect(hour).to_not have_key(:heatindex_f)
      expect(hour).to_not have_key(:dewpoint_c)
      expect(hour).to_not have_key(:dewpoint_f)
      expect(hour).to_not have_key(:will_it_rain)
      expect(hour).to_not have_key(:chance_of_rain)
      expect(hour).to_not have_key(:will_it_snow)
      expect(hour).to_not have_key(:chance_of_snow)
      expect(hour).to_not have_key(:vis_km)
      expect(hour).to_not have_key(:gust_mph)
      expect(hour).to_not have_key(:gust_kph)
    end
  end

  it 'returns a formatted 5-day weather JSON when given a location' do
    daily = @forecast[:attributes][:daily_weather]

    expect(daily.length).to eq(5)

    day = daily.first

    expect(day).to have_key(:date)
    expect(day[:date]).to eq("2024-09-22")

    expect(day).to have_key(:sunrise)
    expect(day[:sunrise]).to eq("06:44 AM")

    expect(day).to have_key(:sunset)
    expect(day[:sunset]).to eq("06:52 PM")

    expect(day).to have_key(:max_temp)
    expect(day[:max_temp]).to eq(76.5)

    expect(day).to have_key(:min_temp)
    expect(day[:min_temp]).to eq(63.7)

    expect(day).to have_key(:condition)
    expect(day[:condition]).to eq("Sunny")

    expect(day).to have_key(:icon)
    expect(day[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/113.png")

    daily.each do |day|
      expect(day).to have_key(:date)
      expect(day).to have_key(:sunrise)
      expect(day).to have_key(:sunset)
      expect(day).to have_key(:max_temp)
      expect(day).to have_key(:min_temp)
      expect(day).to have_key(:condition)
      expect(day).to have_key(:icon)

      expect(day).to_not have_key(:date_epoch)
      expect(day).to_not have_key(:day)
      expect(day).to_not have_key(:astro)
      expect(day).to_not have_key(:hour)
    end
  end
end