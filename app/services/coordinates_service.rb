class CoordinatesService
  def self.find_location(town)
    conn = Faraday.new("https://www.mapquestapi.com")

    response = conn.get("/geocoding/v1/address") do |req|
      req.params[:location] = town
      req.params[:key] = Rails.application.credentials.mapquest[:key]
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end