class CoordinatesFacade
  def self.get_lat_lon(town)
    data = CoordinatesService.find_location(town)
    
    coordinates = data[:results][0][:locations][0][:latLng]
    lat = coordinates[:lat]
    lon = coordinates[:lng]
    "#{lat}, #{lon}"
  end
end