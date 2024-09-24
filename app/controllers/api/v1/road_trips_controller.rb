class Api::V1::RoadTripsController < ApplicationController
  before_action :validate_api_key

  def create
    origin = params[:origin]
    destination = params[:destination]
    road_trip = RoadTripFacade.get_road_trip(origin, destination)

    if road_trip[:error]
      render json: RoutingErrorSerializer.error_json(origin, destination), status: 400
    else
      render json: RoadTripSerializer.road_trip_json(road_trip, origin, destination), status: 200
    end
  end
end