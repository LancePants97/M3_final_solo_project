class ForecastService
  def self.find_forecast(town)
    conn = Faraday.new("http://api.weatherapi.com")

    response = conn.get("/v1/forecast.json") do |req|
      req.params[:key] = Rails.application.credentials.weather[:key]
      req.params[:q] = town
      req.params[:days] = 5
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end