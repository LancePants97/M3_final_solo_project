class RoadTrip
  attr_reader :seconds,
              :travel_time,
              :travel_days,
              :arrival_time,
              :eta_hour

  def initialize(attr)
    @seconds = attr[:time]
    @travel_time = attr[:formattedTime]
    @travel_days = travel_days_calculator(@seconds)
    @arrival_time = arrival_time_calculator(@seconds)
    @eta_hour = eta_hour_calculator(@arrival_time)
  end

  def travel_days_calculator(seconds)
    days = seconds / 86400
    days.truncate # truncate to get rid of any decimals
  end

  def arrival_time_calculator(seconds)
    current = Time.now
    arrival = current + seconds
    arrival
  end

  def eta_hour_calculator(arrival_time)
    arrival_time.hour # grab just the hour from the big time format thing
  end
end