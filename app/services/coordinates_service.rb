class CoordinatesService
  def self.find_location(town)
    conn = Faraday.new("https://www.mapquestapi.com")

    response = conn.get("/geocoding/v1/address") do |req|
      req.params[:location] = town
      req.params[:key] = Rails.application.credentials.mapquest[:key]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_road_trip(origin, destination)
    conn = Faraday.new("https://www.mapquestapi.com")

    response = conn.get("/directions/v2/route") do |req|
      req.params[:key] = Rails.application.credentials.mapquest[:key]
      req.params[:from] = origin
      req.params[:to] = destination
      req.params[:unit] = "m"
    end

    data = JSON.parse(response.body, symbolize_names: true)
    data[:route]
  end
end