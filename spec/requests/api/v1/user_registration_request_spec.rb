require 'rails_helper'

RSpec.describe 'User Registration Request', type: :request do
  before(:each) do
    @body = {
      "email": "lance@turing.com",
      "password": "iloveruby123",
      "password_confirmation": "iloveruby123"
    }
  end

### - HAPPY PATH >:) - ###
  it "successfully creates a user in the database" do
    post "/api/v1/users", params: { user: @body }

    user = User.last
    binding.pry
    expect(user.email).to be_a(String)
    expect(user.email).to eq("lance@turing.com")

    expect(user.password_digest).to be_a(String)
    expect(user.api_key).to be_a(String)
    expect(user.api_key.length).to eq(32)
  end

  it "renders a proper JSON response for the newly created user" do
    post "/api/v1/users", params: { user: @body }

    expect(response.status).to eq(201)

    user = User.last

    json = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json).to have_key(:type)
    expect(json[:type]).to eq("user")

    expect(json).to have_key(:id)
    expect(json[:id]).to be_an(Integer)
    expect(json[:id]).to eq(user.id)

    expect(json[:attributes]).to have_key(:email)
    expect(json[:attributes][:email]).to be_a(String)
    expect(json[:attributes][:email]).to eq(user.email)

    expect(json[:attributes]).to have_key(:api_key)
    expect(json[:attributes][:api_key]).to be_a(String)
    expect(json[:attributes][:api_key].length).to eq(32)
    expect(json[:attributes][:api_key]).to eq(user.api_key)
  end

### - SAD PATH >:C - ###
  it "renders an error JSON if user has no email" do
    wrong_body = {
      "email": "",
      "password": "iloveruby123",
      "password_confirmation": "iloveruby123"
    }

    post "/api/v1/users", params: { user: wrong_body }

    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:errors)
    expect(json[:errors][0]).to be_a(String)
    expect(json[:errors][0]).to eq("Email can't be blank")
  end

  it "renders an error JSON if user password is blank" do
    wrong_body = {
      "email": "bob@example.com",
      "password": "",
      "password_confirmation": ""
    }

    post "/api/v1/users", params: { user: wrong_body }

    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:errors)
    expect(json[:errors][0]).to be_a(String)
    expect(json[:errors][0]).to eq("Password can't be blank")
  end

  it "renders an error JSON if user password confirmation doesn't match" do
    wrong_body = {
      "email": "bob@example.com",
      "password": "iloveruby123",
      "password_confirmation": "ihateruby321"
    }

    post "/api/v1/users", params: { user: wrong_body }

    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:errors)
    expect(json[:errors][0]).to be_a(String)
    expect(json[:errors][0]).to eq("Password confirmation doesn't match Password")
  end

  it "renders an error JSON if user email is already in use" do
    wrong_body = {
      "email": "lance@turing.com",
      "password": "iloveruby123",
      "password_confirmation": "iloveruby123"
    }
    post "/api/v1/users", params: { user: @body }
    post "/api/v1/users", params: { user: wrong_body }

    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json).to have_key(:errors)
    expect(json[:errors][0]).to be_a(String)
    expect(json[:errors][0]).to eq("Email has already been taken")
  end
end