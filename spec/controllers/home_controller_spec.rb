require 'rails_helper'

describe HomeController do
  describe '#reload' do
    it 'redirects to the homepage' do
      get :reload
      response.should redirect_to root_path
    end
  end

  describe '#results' do
    before do
      @location = 'LOCATION'
      controller.stub(:params).and_return({'location_input' => @location})
    end

    it 'stores the location_input from the params with a valid location' do
      Search.any_instance.stub(:gmap_hash)

      post :results

      expect(controller.instance_variable_get(:@searches)).to include(@location)
    end

    it 'creates a latitude and longitude hash for the Gmap builder with a valid location' do
      gmap_hash = 'gmap-hash'
      Search.any_instance.stub(:gmap_hash).and_return(gmap_hash)

      post :results

      expect(controller.instance_variable_get(:@gmap_hash)).to eql(gmap_hash)
    end

    it 'sets a flash error when an error is raised' do
      allow(Search).to receive(:new).and_raise('error')

      post :results

      expect(flash[:form_error]).to eql('Please enter a valid location')
    end

    it 'redirects back when an error is raised' do
      allow(Search).to receive(:new).and_raise('error')

      post :results

      response.should redirect_to root_path
    end
  end

end