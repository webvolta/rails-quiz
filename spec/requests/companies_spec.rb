require 'rails_helper'

RSpec.describe "Companies", type: :request do
  describe "GET /search" do
    it "returns http success" do
      get "/companies/search/page/1", params: { search: {per_page: 1, name: "Cas"} }
      expect(response).to have_http_status(:success)
    end
  end

end
