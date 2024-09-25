require 'rails_helper'

RSpec.describe RoadTrip do
  describe "Road Trip PORO" do
    before(:each) do
      json = { # (these were the only necessary attributes)
              :realTime=>142624,
              :distance=>2792.3141,
              :time=>139949,
              :formattedTime=>"38:52:29"
            }

      @trip = RoadTrip.new(json)
    end

    it "creates the correct attributes from the given JSON" do
      expect(@trip.arrival_time).to be_a(Time)
      expect(@trip.seconds).to be_an(Integer)
      expect(@trip.travel_time).to be_a(String)
      expect(@trip.travel_days).to be_an(Integer)
      expect(@trip.travel_days).to eq(1)
      expect(@trip.eta_hour).to be_an(Integer)
    end

    it "calculates travel days" do
      days = @trip.seconds / 86400
      expect(@trip.travel_days_calculator(@trip.seconds)).to eq(days)
    end

    it "calculates hour of arrival" do
      arrival_time = (Time.new(2024, 9, 24, 12, 30, 00))

      expect(@trip.eta_hour_calculator(arrival_time)).to eq(12)
    end
  end
end