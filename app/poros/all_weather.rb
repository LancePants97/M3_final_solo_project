class AllWeather
  attr_reader :current,
              :hourly,
              :forecast
              
  def initialize(current, hourly, forecast)
    @current = current
    @hourly = hourly
    @forecast = forecast
  end
end