require 'geocoder'

class Search
  def initialize(location)
    geocode_response = Geocoder.search(location).first
    raise 'The location returned no results' unless geocode_response.present?
    @geocode = geocode_response
  end

  def gmap_hash
    { 'lat' => latitude, 'lng' => longitude }
  end

  def latitude
    geometry_location['lat']
  end

  def longitude
    geometry_location['lng']
  end

  private

  def data
    @geocode.instance_variable_get(:@data)
  end

  def geometry_location
    data['geometry']['location']
  end
end