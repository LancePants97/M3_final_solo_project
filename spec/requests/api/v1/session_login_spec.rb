require 'rails_helper'

RSpec.describe 'User Registration Request', type: :request do
  before(:each) do
    # @body = {
    #   "email": "lance@turing.com",
    #   "password": "iloveruby123",
    #   "password_confirmation": "iloveruby123"
    # }
  end

  it "logs in" do
    # post "/api/v1/users", params: { user: @body }
    user = User.create!(email: "lance@turing.com", password: "iloveruby123")
    
    post "/api/v1/sessions", params: { user: {email: user.email, password: user.password} }
    
    expect(response.status).to eq(400)
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    # binding.pry
  end

end