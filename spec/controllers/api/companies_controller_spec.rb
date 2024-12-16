require 'rails_helper'

RSpec.describe Api::CompaniesController, type: :controller do
  describe 'GET /api/companies' do
    let!(:companies) { create_list(:company, 25) }

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns paginated results' do
      get :index, params: { page: 1, per_page: 10 }
      json = JSON.parse(response.body)
      expect(json['meta']['current_page']).to eq(1)
      expect(json['meta']['total_pages']).to eq(3)
      expect(json['data'].size).to eq(10)
    end

    it 'returns filtered results by name' do
      create(:company, name: 'Acme Corp')
      get :index, params: { name: 'acme' }
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(1)
      expect(json['data'][0]['name']).to eq('Acme Corp')
    end

    it 'handles case-insensitive filtering' do
      create(:company, name: 'TestCompany')
      get :index, params: { name: 'testcompany' }
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(1)
      expect(json['data'][0]['name']).to eq('TestCompany')
    end

    it 'returns an empty array if no companies match the filter' do
      get :index, params: { name: 'nonexistent' }
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(0)
    end
  end
end
