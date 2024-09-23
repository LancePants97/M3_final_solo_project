require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_uniqueness_of(:api_key)}
  end

  describe "instance methods" do
    it "creates unique api keys for all users" do
      users = FactoryBot.create_list(:user, 100)

      api_keys = users.map(&:api_key)
      unique_api_keys = api_keys.uniq

      expect(api_keys.length).to eq(unique_api_keys.length)
    end
  end
end