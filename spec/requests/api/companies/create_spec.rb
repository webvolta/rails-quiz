require 'rails_helper'

describe 'POST api/companies', type: :request do
  let(:companies_params) { { companies: [{ name: 'ABC Co.' }, name: 'XYZ Inc.'] } }

  context 'authorized' do
    it 'should create valid companies' do
      post '/api/companies', params: companies_params, headers: basic_auth_header
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json.first[:id]).not_to be_nil
      expect(json.first[:name]).to eq('ABC Co.')
      expect(json.last[:id]).not_to be_nil
      expect(json.last[:name]).to eq('XYZ Inc.')
    end

    it 'should not create invalid companies' do
      invalid_params = { companies: [name: nil] }

      post '/api/companies', params: invalid_params, headers: basic_auth_header
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(400)
      expect("Failed to create companies!").to eq(json[:error])
    end
  end

  context 'not authorized' do
    it 'should not process the request' do
      post '/api/companies', params: companies_params
      expect(response).to have_http_status(401)
    end
  end
end
