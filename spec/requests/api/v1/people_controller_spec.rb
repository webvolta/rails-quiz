require 'rails_helper'

RSpec.describe Api::V1::PeopleController do
  after(:each) do
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end

  context 'no query params' do
    let!(:people) { create_list(:person, 20) }

    it 'returns people with pagination defaults' do
      get '/api/v1/people'

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.count).to eq(10)
    end
  end

  context 'with email filtering param' do
    let!(:people) do
      [create(:person, email: 'test1@example.com'),
       create(:person, email: 'test2@example.com')]
    end

    it 'filters persons by email address' do
      get '/api/v1/people', params: { email: 'test2@example.com' }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body.count).to eq(1)
      expect(body[0]['email']).to eq('test2@example.com')
    end
  end
end
