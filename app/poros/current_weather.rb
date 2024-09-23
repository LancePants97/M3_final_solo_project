class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :condition,
              :icon
  
  def initialize(attr)
    @last_updated = attr[:last_updated]
    @temperature = attr[:temp_f]
    @feels_like = attr[:feelslike_f]
    @humidity = attr[:humidity]
    @uvi = attr[:uv]
    @visibility = attr[:vis_miles]
    @condition = attr[:condition][:text]
    @icon = attr[:condition][:icon]
  end
end