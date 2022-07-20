require 'rails_helper'

RSpec.describe 'Search for a company', type: :request do
  describe 'GET /serach_company?[params]' do
    context 'when the request is valid' do
      before do
        @company1 = create(:company, name: 'Company1')
        get '/serach_company/?name=com'
        res1 = JSON.parse(response.body)
        expect(res1['data'].count).to eq(1)
        expect(res1['data'][0]['name']).to eq(@company1.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        @company3 = create(:company, name: 'Six Flags')
        @company4 = create(:company, name: 'Marvel Studios')
        get '/serach_company?name=Disney World'
      end

      it 'returns an error' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
