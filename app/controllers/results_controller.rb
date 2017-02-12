class ResultsController < ApplicationController
  def index
    @location = params['location_input'].upcase

    search_obj = Search.new(@location)

    @searches = params['searches'] ? JSON.parse(params['searches']) << @location : [@location]

    @gmap_hash = {"lat" => search_obj.latitude, "lng" => search_obj.longitude}
  end
end