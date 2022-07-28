require 'rails_helper'

RSpec.describe Api::V1::CompaniesController do
  after(:each) do
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end

  describe 'GET /api/v1/companies' do
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

  describe 'POST /api/v1/companies' do
    let(:headers) { { 'ACCEPT': 'application/json' } }

    context 'create single company' do
      let(:payload) { { company: { name: 'test1' } } }

      it 'creates and returns the created company' do
        post '/api/v1/companies', params: payload, headers: headers

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(body['id']).to eq(1)
        expect(body['name']).to eq('test1')
      end
    end

    context 'create multiple companies' do
      let(:payload) do
        { companies: [{ name: 'test1' }, { name: 'test2' }] }
      end

      it 'creates and returns the created company' do
        post '/api/v1/companies', params: payload, headers: headers

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(body.count).to eq(2)

        expect(body[0]['id']).to eq(1)
        expect(body[0]['name']).to eq('test1')

        expect(body[1]['id']).to eq(2)
        expect(body[1]['name']).to eq('test2')
      end
    end

    context 'company unable to be saved' do
      let(:payload) { { company: { name: nil } } }

      it 'returns error' do
        post '/api/v1/companies', params: payload, headers: headers

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body[0]).to eq('Name can\'t be blank')
      end
    end
  end
end
