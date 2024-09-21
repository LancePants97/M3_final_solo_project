class Api::V1::CoordinatesController < ApplicationController
  def index
    town = params[:location]
    @coordinates = CoordinatesFacade.get_lat_lon(town)
  end
end