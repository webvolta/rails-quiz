require 'rails_helper'

RSpec.describe 'Search for a person', type: :request do
  describe 'GET /search_person?[params]' do
    context 'when the request is valid' do
      before do
        @person1 = create(:person, name: 'John', email: 'john@doe.com', phone_number: '555-555-5555')
        @person2 = create(:person, name: 'Alvez', email: 'alvez@doe.com', phone_number: '777-777-7777')
        get '/search_person/?email=doe.com'
        res = JSON.parse(response.body)
        expect(res['data'].count).to eq(2)
        expect(res['data'][0]['email']).to eq(@person1.email)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item that matches the name' do
        get '/search_person/?name=john'
        res = JSON.parse(response.body)
        expect(res['data'].count).to eq(2)
        expect(res['data'][0]['name'].capitalize).to eq(@person1.name)
      end
    end
  end
end
