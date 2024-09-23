require "rails_helper"

RSpec.describe "Forecast Service" do
  describe "searches the weather API for forecasts and returns json with necessary attributes" do      
    before(:each) do
      town = "Point Pleasant, NJ"
      @results = ForecastService.find_forecast(town)

      @current = @results[:current]
      @hourly = @results[:forecast][:forecastday][0][:hour]
      @daily = @results[:forecast][:forecastday]
    end

    it "contains necessary data in JSON response" do
      expect(@results).to be_a(Hash)
      expect(@results).to have_key(:location)
      expect(@results).to have_key(:current)
      expect(@results).to have_key(:forecast)
    end

    it "returns necessary data for current forecast" do
      expect(@current).to have_key :last_updated
      expect(@current[:last_updated]).to be_a(String)

      expect(@current).to have_key :temp_f
      expect(@current[:temp_f]).to be_a(Float)

      expect(@current).to have_key :feelslike_f
      expect(@current[:feelslike_f]).to be_a(Float)

      expect(@current).to have_key :humidity
      expect(@current[:humidity]).to be_an(Integer)

      expect(@current).to have_key :uv
      expect(@current[:uv]).to be_a(Float)

      expect(@current).to have_key :vis_miles
      expect(@current[:vis_miles]).to be_a(Float)

      expect(@current).to have_key :condition
      expect(@current[:condition]).to be_a(Hash)

      expect(@current[:condition]).to have_key :text
      expect(@current[:condition][:text]).to be_a(String)

      expect(@current[:condition]).to have_key :icon
      expect(@current[:condition][:icon]).to be_a(String)
    end

    it "returns necessary data for hourly forecast" do
      expect(@hourly.length).to eq(24)
        
      @hourly.each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)

        expect(hour).to have_key(:temp_f)
        expect(hour[:temp_f]).to be_a(Float)

        expect(hour).to have_key(:condition)
        expect(hour[:condition]).to be_a(Hash)

        expect(hour[:condition]).to have_key(:text)
        expect(hour[:condition][:text]).to be_a(String)

        expect(hour[:condition]).to have_key(:icon)
        expect(hour[:condition][:icon]).to be_a(String)
      end
    end

    it "returns necessary data for 5-day forecast" do
      expect(@daily.length).to eq(5)

      @daily.each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)

        expect(day[:astro]).to have_key(:sunrise)
        expect(day[:astro][:sunrise]).to be_a(String)

        expect(day[:astro]).to have_key(:sunset)
        expect(day[:astro][:sunset]).to be_a(String)

        expect(day[:day]).to have_key(:maxtemp_f)
        expect(day[:day][:maxtemp_f]).to be_a(Float)

        expect(day[:day]).to have_key(:mintemp_f)
        expect(day[:day][:mintemp_f]).to be_a(Float)

        expect(day[:day]).to have_key(:condition)
        expect(day[:day][:condition]).to be_a(Hash)

        expect(day[:day][:condition]).to have_key(:text)
        expect(day[:day][:condition][:text]).to be_a(String)

        expect(day[:day][:condition]).to have_key(:icon)
        expect(day[:day][:condition][:icon]).to be_a(String)
      end
    end
  end
end