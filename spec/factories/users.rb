FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password123' }
    api_key { SecureRandom.hex(16) }
  end
end
