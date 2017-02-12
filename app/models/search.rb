require 'geocoder'

class Search
  def initialize(location)
    @geocode = Geocoder.search(location)[0]
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