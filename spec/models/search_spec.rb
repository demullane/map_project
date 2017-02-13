require 'rails_helper'

describe Search do
  before do
    @latitude = 39.7392358
    @longitude = -104.990251
    data = {'geometry' => { "location" => { "lat" => @latitude, "lng" => @longitude } } }

    @geocoder_response = Object.new
    @geocoder_response.instance_variable_set(:@data, data)

    Geocoder.stub_chain(:search, :first).and_return(@geocoder_response)
  end

  describe '#initalize' do
    it 'adds the response from Geocoder as an instance variable to the new Search object when there is a response' do
      result = Search.new('location')
      expect(result.instance_variable_get(:@geocode)).to eql(@geocoder_response)
    end

    it 'raises an error when there is no Geocoder response' do
      Geocoder.stub_chain(:search, :first).and_return(nil)
      expect{Search.new('invalid-location')}.to raise_error(StandardError)
    end
  end

  describe '#gmap_hash' do
    it 'returns a hash with the latitude and longitude values of the Geocode response' do
      hash = { 'lat' => @latitude, 'lng' => @longitude }
      expect(Search.new('location').gmap_hash).to eql(hash)
    end
  end

  describe '#latitude' do
    it 'returns the latitude value of the Geocode response' do
      expect(Search.new('location').latitude).to eql(@latitude)
    end
  end

  describe '#longitude' do
    it 'returns the longitude value of the Geocode response' do
      expect(Search.new('location').longitude).to eql(@longitude)
    end
  end
end