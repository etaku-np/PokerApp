require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET top" do
    before do
      get :top
    end
    it "returns Status: 200" do
      expect(response.status).to eq 200
    end
    it "renders actual template" do
      expect(response).to render_template :top
    end
  end

  describe "POST check" do
    before do
      post :check
    end
    it "returns Status: 302" do
      expect(response.status).to eq 302
    end
    it "redirects to top_url" do
      expect(response).to redirect_to "/"
    end
  end

end