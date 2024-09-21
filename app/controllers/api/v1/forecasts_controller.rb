class Api::V1::ForecastsController < ApplicationController
  def index
    town = params[:location]

    current_forecast = ForecastFacade.get_current_forecast(town)
    hourly_forecast = ForecastFacade.get_hourly_forecast(town)
    five_day_forecast = ForecastFacade.get_five_day_forecast(town)
    
    forecast = ForecastFacade.get_all_weather(current_forecast, hourly_forecast, five_day_forecast)
    
    render json: ForecastSerializer.weather_json(forecast)
    
    # binding.pry

    # begin
    #   render json: MarketSerializer.show_market(Market.find(params[:id]))
    # rescue ActiveRecord::RecordNotFound => exception
    #   render json: {
    #     errors: [
    #       {
    #         status: '404',
    #         detail: exception.message
    #       }
    #     ]
    # }, status: :not_found
    # end
  end
end