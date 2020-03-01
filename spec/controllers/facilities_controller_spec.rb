require 'rails_helper'

RSpec.describe FacilitiesController, type: :controller do
  describe 'GET index' do
    it 'works' do
      get :index
      expect(response).to have_http_status(:ok)
    end
    
    # it "assigns @teams" do
    #   team = Team.create
    #   get :index
    #   expect(response).to have_http_status(:created
    #   expect(assigns(:teams)).to eq([team])
    # end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end
