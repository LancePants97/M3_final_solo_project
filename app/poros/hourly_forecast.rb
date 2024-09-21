class HourlyForecast
  attr_reader :time,
              :temperature,
              :condition,
              :icon

  def initialize(attr)
    @time = attr[:time]
    @temperature = attr[:temp_f]
    @condition = attr[:condition][:text]
    @icon = attr[:condition][:icon]
  end
end