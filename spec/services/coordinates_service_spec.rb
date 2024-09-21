require "rails_helper"

RSpec.describe "Coordinates Service" do
  it "searches our API for a location" do
    VCR.use_cassette("mapquest_api") do
      town = "Point Pleasant, NJ"

      results = CoordinatesService.find_location(town)

      expect(results).to have_key(:info)
      expect(results).to have_key(:results)

      location = results[:results][0][:locations][0]

      expect(location).to have_key :latLng
      expect(location[:latLng]).to be_a(Hash)
      expect(location[:latLng]).to eq( {:lat=>40.0723, :lng=>-74.07124} )
    end
  end
end