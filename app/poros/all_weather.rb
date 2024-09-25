class AllWeather
  attr_reader :current,
              :hourly,
              :forecast
              
  def initialize(current, hourly, forecast)
    # binding.pry
    @current = current
    @hourly = hourly
    @forecast = forecast
  end
end