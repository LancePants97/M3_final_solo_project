require 'rails_helper'

RSpec.describe "RoadTripacade" do
  it "should call the facade and retrieve location results" do
    origin = "New York, NY"
    destination = "Los Angeles, CA"

    road_trip = RoadTripFacade.get_road_trip(origin, destination)

    expect(road_trip).to have_key(:road_trip)
    expect(road_trip).to have_key(:forecast)

    expect(road_trip[:road_trip].arrival_time).to be_a(Time)
    expect(road_trip[:road_trip].eta_hour).to be_an(Integer)
    expect(road_trip[:road_trip].seconds).to be_an(Integer)
    expect(road_trip[:road_trip].travel_days).to be_an(Integer)
    expect(road_trip[:road_trip].travel_time).to be_an(String)
  end

  it "should call the facade and return an error if impossible route" do
    origin = "New York, NY"
    destination = "London, UK"

    error = RoadTripFacade.get_road_trip(origin, destination)

    expect(error).to have_key(:error)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq("impossible route")
  end
end