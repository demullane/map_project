require 'rails_helper'

describe HomeController do

  describe '#results' do
    before do
      @location = 'LOCATION'
      controller.stub(:params).and_return({'location_input' => @location})
    end

    it 'stores the location_input from the params with a valid location' do
      Search.any_instance.stub(:validated?).and_return(true)
      Search.any_instance.stub(:gmap_hash)

      post :results

      expect(controller.instance_variable_get(:@searches)).to include(@location)
    end

    it 'creates a latitude and longitude hash for the Gmap builder with a valid location' do
      gmap_hash = 'gmap-hash'
      Search.any_instance.stub(:validated?).and_return(true)
      Search.any_instance.stub(:gmap_hash).and_return(gmap_hash)

      post :results

      expect(controller.instance_variable_get(:@gmap_hash)).to eql(gmap_hash)
    end

    it 'sets a flash error with an invalid location' do
      Search.any_instance.stub(:validated?).and_return(false)
      request.env["HTTP_REFERER"] = "where_i_came_from"

      post :results

      expect(flash[:form_error]).to eql('Please enter a valid location')
    end

    it 'redirects back with an invalid location' do
      http_referer = 'results-page'
      Search.any_instance.stub(:validated?).and_return(false)
      request.env["HTTP_REFERER"] = http_referer

      post :results

      response.should redirect_to http_referer
    end
  end

end