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
    
    # expect(response.status).to eq(200)
    
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    # binding.pry
  end
end