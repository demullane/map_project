class ResultsController < ApplicationController
  def index
    search_obj = Search.new('denver')

    @gmap_hash = {"lat" => search_obj.latitude, "lng" => search_obj.longitude}
  end
end