require 'rails_helper'

RSpec.describe 'Road Trip Request', type: :request do
### - HAPPY PATH >:) - ###

  it "creates a road trip with a proper JSON response" do
    user1 = User.create!(email: "Lance@turingschool.com", password: "iloveruby123")
    user2 = User.create!(email: "Jan@turingschool.com", password: "loyalsquire123")
    user3 = User.create!(email: "Cory@turingschool.com", password: "asdf123")
    user4 = User.create!(email: "Evan@turingschool.com", password: "herokusux123")
    user5 = User.create!(email: "Dana@turingschool.com", password: "puppymama123")
    user6 = User.create!(email: "AustinK@turingschool.com", password: "conquerorofoauth123")
    user7 = User.create!(email: "Tyler@turingschool.com", password: "bootstrapbaddie123")
    user8 = User.create!(email: "Kat@turingschool.com", password: "bestinstructorever123")

    origin = "New York, NY"
    destination = "Los Angeles, CA"

    post "/api/v1/sessions", params: { email: user1.email, password: user1.password } 

    post "/api/v1/road_trip", params: { origin: origin, destination: destination, api_key: user1.api_key } 

    expect(response.status).to eq(200)

    json = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json).to have_key(:id)
    expect(json[:id]).to eq(nil)

    expect(json).to have_key(:type)
    expect(json[:type]).to be_a(String)
    expect(json[:type]).to eq("road_trip")

    expect(json).to have_key(:attributes)
    expect(json[:attributes]).to be_a(Hash)

    attrs = json[:attributes]

    expect(attrs).to have_key(:start_city)
    expect(attrs[:start_city]).to be_a(String)
    expect(attrs[:start_city]).to eq("New York, NY")

    expect(attrs).to have_key(:end_city)
    expect(attrs[:end_city]).to be_a(String)
    expect(attrs[:end_city]).to eq("Los Angeles, CA")

    expect(attrs).to have_key(:travel_time)
    expect(attrs[:travel_time]).to be_a(String)

    expect(attrs).to have_key(:weather_at_eta)
    expect(attrs[:weather_at_eta]).to be_a(Hash)

    expect(attrs[:weather_at_eta]).to have_key(:datetime)
    expect(attrs[:weather_at_eta][:datetime]).to be_a(String)

    expect(attrs[:weather_at_eta]).to have_key(:temperature)
    expect(attrs[:weather_at_eta][:temperature]).to be_a(Float)

    expect(attrs[:weather_at_eta]).to have_key(:condition)
    expect(attrs[:weather_at_eta][:condition]).to be_a(String)
  end

### - SAD PATH >:C - ###
  it "returns the proper error for a missing API key" do
    user1 = User.create!(email: "Lance@turingschool.com", password: "iloveruby123")
    user2 = User.create!(email: "Jan@turingschool.com", password: "loyalsquire123")

    origin = "New York, NY"
    destination = "Los Angeles, CA"

    post "/api/v1/sessions", params: { email: user1.email, password: user1.password } 

    post "/api/v1/road_trip", params: { origin: origin, destination: destination } 

    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Missing API Key")
  end

  it "returns the proper error for a blank API key" do
    user1 = User.create!(email: "Lance@turingschool.com", password: "iloveruby123")
    user2 = User.create!(email: "Jan@turingschool.com", password: "loyalsquire123")

    origin = "New York, NY"
    destination = "Los Angeles, CA"

    post "/api/v1/sessions", params: { email: user1.email, password: user1.password } 

    post "/api/v1/road_trip", params: { origin: origin, destination: destination, api_key: "" } 

    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Missing API Key")
  end

  it "returns the proper error for an incorrect API key" do
    user1 = User.create!(email: "Lance@turingschool.com", password: "iloveruby123")
    key = user1.api_key
    new_chars = "abcd"
    wrong_key = key[0..-5] + new_chars

    origin = "New York, NY"
    destination = "Los Angeles, CA"

    post "/api/v1/sessions", params: { email: user1.email, password: user1.password } 

    post "/api/v1/road_trip", params: { origin: origin, destination: destination, api_key: wrong_key } 

    expect(response.status).to eq(401)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:error)
    expect(json[:error]).to eq("Unauthorized API Key Request")
  end

  it "returns the proper error for a bad destination" do
    user1 = User.create!(email: "Lance@turingschool.com", password: "iloveruby123")

    origin = "New York, NY"
    destination = "London, UK"

    post "/api/v1/sessions", params: { email: user1.email, password: user1.password } 

    post "/api/v1/road_trip", params: { origin: origin, destination: destination, api_key: user1.api_key} 

    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json).to have_key(:id)
    expect(json[:id]).to eq(nil)

    expect(json).to have_key(:type)
    expect(json[:type]).to be_a(String)
    expect(json[:type]).to eq("error")

    expect(json).to have_key(:attributes)
    expect(json[:attributes]).to be_a(Hash)

    attrs = json[:attributes]

    expect(attrs).to have_key(:start_city)
    expect(attrs[:start_city]).to be_a(String)
    expect(attrs[:start_city]).to eq("New York, NY")

    expect(attrs).to have_key(:end_city)
    expect(attrs[:end_city]).to be_a(String)
    expect(attrs[:end_city]).to eq("London, UK")

    expect(attrs).to have_key(:travel_time)
    expect(attrs[:travel_time]).to be_a(String)
    expect(attrs[:travel_time]).to eq("impossible route")

    expect(attrs).to have_key(:weather_at_eta)
    expect(attrs[:weather_at_eta]).to be_a(Hash)

    expect(attrs[:weather_at_eta]).to have_key(:datetime)
    expect(attrs[:weather_at_eta][:datetime]).to eq(nil)

    expect(attrs[:weather_at_eta]).to have_key(:temperature)
    expect(attrs[:weather_at_eta][:temperature]).to eq(nil)

    expect(attrs[:weather_at_eta]).to have_key(:condition)
    expect(attrs[:weather_at_eta][:condition]).to eq(nil)
  end
end