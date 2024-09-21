class Api::V1::ForecastsController < ApplicationController
  def index
    town = params[:location]
    forecast = ForecastFacade.get_five_day_forecast(town)
    # binding.pry
    # binding.pry

    # render json: ForecastSerializer.weather_json(forecast)



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