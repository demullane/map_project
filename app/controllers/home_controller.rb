class HomeController < ApplicationController

  def index
  end

  def reload
    redirect_to '/'
  end

  def results
    location = params['location_input'].upcase
    location_data = Search.new(location)

    if location_data.validated?
      @searches = params['searches'] ? JSON.parse(params['searches']) << location : [location]
      @searches.uniq!

      @gmap_hash = location_data.gmap_hash
    else
      redirect_to :back, flash: {form_error: 'Please enter a valid location'}
    end
  end
end