require 'rails_helper'

RSpec.describe 'Weather Forecast Request', type: :request do
  it 'returns a forecast JSON when given coordinates' do
    VCR.use_cassette("forecast_api_call") do
      location = "Point Pleasant, NJ"
      # coordinates = CoordinatesFacade.get_lat_lon(town)
      # binding.pry
      get "/api/v1/forecast", params: { location: location}

      # forecast = JSON.parse(response.body, symbolize_names: true)[:data]
    end
  end
end