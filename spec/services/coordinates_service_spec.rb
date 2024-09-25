require "rails_helper"

RSpec.describe "Coordinates Service" do
  it "searches our API for a location" do
    town = "Denver, CO"
    api_key = Rails.application.credentials.mapquest[:key]
    body = { results: 
                  [{ locations: 
                    [{ latLng: { lat: 40.0723, lng: -74.07124 } 
                    }]
                  }] 
          }.to_json

    stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address")
      .with(query: { location: town, key: api_key })
      .to_return(status: 200, body: body)

    results = CoordinatesService.find_location(town)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:results)
    expect(results[:results]).to be_an(Array)

    location = results[:results][0][:locations][0]

    expect(location).to have_key :latLng
    expect(location[:latLng]).to be_a(Hash)
    expect(location[:latLng]).to eq( {:lat=>40.0723, :lng=>-74.07124} )
  end

  it "searches our API to find directions for a road trip" do
    origin = "New York, NY"
    destination = "Los Angeles"
    api_key = Rails.application.credentials.mapquest[:key]
    body = { route: 
              { time: 139815,
                formattedTime: "38:50:15" 
              } 
            }.to_json
  
    stub_request(:get, "https://www.mapquestapi.com/directions/v2/route")
      .with(query: { key: api_key, from: origin, to: destination, unit: "m" })
      .to_return(status: 200, body: body)

    results = CoordinatesService.get_road_trip(origin, destination)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:time)
    expect(results[:time]).to eq(139815)
    expect(results).to have_key(:formattedTime)
    expect(results[:formattedTime]).to eq("38:50:15")
  end
end