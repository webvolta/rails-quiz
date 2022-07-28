require 'rails_helper'

RSpec.describe Api::V1::CompaniesController do
  after(:each) do
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end

  context 'no query params' do
    let!(:companies) { create_list(:company, 20) }

    it 'returns people with pagination defaults' do
      get '/api/v1/companies'

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.count).to eq(10)
    end
  end

  context 'with company name filtering' do
    let!(:companies) { create(:company, name: 'Tester Incorporated') }

    it 'performs a partial case-insensitive search of company name' do
      get '/api/v1/companies', params: { name: 'StEr' }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.count).to eq(1)
      expect(body.first['name']).to eq('Tester Incorporated')
    end
  end
end
