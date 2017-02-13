class HomeController < ApplicationController

  def index
  end

  def reload
    redirect_to root_path
  end

  def results
    location = params['location_input'].upcase
    location_data = Search.new(location)

    @searches = params['searches'] ? JSON.parse(params['searches']) << location : [location]
    @searches.uniq!

    @gmap_hash = location_data.gmap_hash
  rescue
    redirect_to root_path, flash: {form_error: 'Please enter a valid location'}
  end
end