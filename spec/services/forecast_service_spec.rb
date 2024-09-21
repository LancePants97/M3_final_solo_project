require "rails_helper"

RSpec.describe "Forecast Service" do
  it "searches the weather API for forecasts" do
    VCR.use_cassette("forecast") do
      town = "Point Pleasant, NJ"

      results = ForecastService.find_forecast(town)
      expect(results).to have_key(:location)
      expect(results).to have_key(:current)
      expect(results).to have_key(:forecast)
      
      current = results[:current]
      hourly = results[:forecast][:forecastday][0]
      daily = results[:forecast][:forecastday]

      expect(daily.length).to eq(5)
      
      expect(current).to have_key :last_updated
      expect(current[:last_updated]).to be_a(String)

      expect(current).to have_key :temp_f
      expect(current[:temp_f]).to be_a(Float)

      expect(current).to have_key :feelslike_f
      expect(current[:feelslike_f]).to be_a(Float)

      expect(current).to have_key :humidity
      expect(current[:humidity]).to be_an(Integer)

      expect(current).to have_key :uv
      expect(current[:uv]).to be_a(Float)

      expect(current).to have_key :vis_miles
      expect(current[:vis_miles]).to be_a(Float)

      expect(current).to have_key :condition
      expect(current[:condition]).to be_a(Hash)

      expect(current[:condition]).to have_key :text
      expect(current[:condition][:text]).to be_a(String)

      expect(current[:condition]).to have_key :icon
      expect(current[:condition][:icon]).to be_a(String)
    end
  end
end