class HomeController < ApplicationController
  include HomeHelper

  def index
  end

  def reload
    redirect_to '/'
  end

  def results
    location = params['location_input'].upcase
    location_data = Search.new(location)

    if location_data.validated?
      retain_search(location)
      create_gmap_location(location_data)
    else
      redirect_to :back, flash: {form_error: 'Please enter a valid location'}
    end
  end
end