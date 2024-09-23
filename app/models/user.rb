class User < ApplicationRecord
  before_create :create_api_key
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :api_key, presence: true, uniqueness: true, allow_nil: true

  has_secure_password

  private

  def create_api_key
    loop do
      self.api_key = SecureRandom.hex(16)
      break unless self.class.exists?(api_key: api_key)
    end
  end
end