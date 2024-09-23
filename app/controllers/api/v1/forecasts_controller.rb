class Api::V1::ForecastsController < ApplicationController
  def index
    town = params[:location]

    current_forecast = ForecastFacade.get_current_forecast(town)
    hourly_forecast = ForecastFacade.get_hourly_forecast(town)
    five_day_forecast = ForecastFacade.get_five_day_forecast(town)
    
    forecast = ForecastFacade.get_all_weather(current_forecast, hourly_forecast, five_day_forecast)
    
    render json: ForecastSerializer.weather_json(forecast)
  end
end