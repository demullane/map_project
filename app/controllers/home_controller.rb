class HomeController < ApplicationController
  def index
  end

  def reload
    redirect_to '/'
  end

  def results
    @location = params['location_input'].upcase
    search_obj = Search.new(@location)

    if search_obj.validated?
      @searches = params['searches'] ? JSON.parse(params['searches']) << @location : [@location]
      @searches.uniq!

      @gmap_hash = {"lat" => search_obj.latitude, "lng" => search_obj.longitude}
    else
      redirect_to :back, flash: {form_error: 'Please enter a valid location'}
    end
  end
end