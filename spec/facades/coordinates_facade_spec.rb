require 'rails_helper'

RSpec.describe "CoordinatesFacade" do
  it "should call the facade and retrieve location results" do
    town = "Point Pleasant, NJ"

    results = CoordinatesFacade.get_lat_lon(town)

    expect(results).to be_a(String)
    expect(results).to eq("40.0723, -74.07124")
  end
end