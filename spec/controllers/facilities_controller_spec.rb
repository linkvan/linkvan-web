require 'rails_helper'

RSpec.describe FacilitiesController, type: :controller do
  fixtures :facilities

  describe 'GET index' do
    let(:open_all_day) { facilities(:open_all_day) } 

    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template("index")
    end

    it 'assigns @facilities' do
      # facility = Facility.create
      get :index
      expect(assigns(:facilities)).to include(open_all_day)
    end
  end
end
