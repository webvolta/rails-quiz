require 'rails_helper'

RSpec.describe 'Create Multiple Companies', type: :request do
  let(:company) { create(:company) }
  let(:companies) { build_list(:company, 10) }

  describe 'POST /companies/create_multiple_companies' do
    context 'when the request is valid' do
      before do
        # post '/create_multiple_companies', params: { companies: companies }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
        post '/create_multiple_companies', params: { companies: companies.map do |comp|
          { name: comp[:name] }
        end }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
      end

      it 'creates multiple companies' do
        res = JSON.parse(response.body)
        expect(res['data'].size).to eq(companies.size)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the authentication fails' do
      before do
        post '/create_multiple_companies', params: { companies: [1, 2, 3, 4, 5, 6, 7].map do |company|
                                                                  { name: company }
                                                                end }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhhll', 'secretll') }
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
  context 'when the request is invalid' do
    before do
      post '/create_multiple_companies', params: { companies: [1, 2, 3, 4, 5, 6, 7].map do |company|
                                                                { name: company }
                                                              end }, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    end
    it 'returns a validation failure message' do
      res = JSON.parse(response.body)
      expect(res['data']).to_not eq(companies.size)
    end
  end
end
