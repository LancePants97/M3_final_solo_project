require 'rails_helper'

RSpec.describe "Mapquest API", type: :request do
  it "returns a set of coordinates when given appropriate parameters" do
    VCR.use_cassette("mapquest_api") do
      get "/api/v1/coordinates", params: {location: "Point Pleasant, NJ"}

      expect(response).to be_successful

      
      
      # binding.pry
    end
  end
end