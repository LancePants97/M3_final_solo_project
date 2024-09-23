class FiveDayForecast
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :condition,
              :icon

  def initialize(attr)
    @date = attr[:date]
    @sunrise = attr[:astro][:sunrise]
    @sunset = attr[:astro][:sunset]
    @max_temp = attr[:day][:maxtemp_f]
    @min_temp = attr[:day][:mintemp_f]
    @condition = attr[:day][:condition][:text]
    @icon = attr[:day][:condition][:icon]
  end
end