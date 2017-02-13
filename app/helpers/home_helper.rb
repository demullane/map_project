module HomeHelper

  def retain_search(location)
    @searches = params['searches'] ? JSON.parse(params['searches']) << location : [location]
    @searches.uniq!
  end

  def create_gmap_location(location_data)
    @gmap_hash = {"lat" => location_data.latitude, "lng" => location_data.longitude}
  end

end