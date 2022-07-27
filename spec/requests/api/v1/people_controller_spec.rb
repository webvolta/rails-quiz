require 'rails_helper'

RSpec.describe Api::V1::PeopleController do
  let(:person_double) { class_double(Person) }
  let(:ar_double) { double(ActiveRecord::Relation) }

  after(:each) do
    expect(response.content_type).to eq('application/json; charset=utf-8')
  end

  context 'no query params (defaults)' do
    before do
      allow(Person).to receive(:page).and_return(ar_double)

      allow(ar_double).to receive(:per)
    end

    it 'returns people with page and per as nil' do
      get '/api/v1/people'

      expect(response).to have_http_status(:ok)

      expect(Person).to have_received(:page).with(nil)
      expect(ar_double).to have_received(:per).with(nil)
    end
  end

  context 'with email param' do
    context 'with valid email' do
      before do
        allow(Person).to receive(:where).and_return(ar_double)

        allow(ar_double).to receive(:page).and_return(ar_double)

        allow(ar_double).to receive(:per)
      end

      it 'filters persons by email address' do
        get '/api/v1/people', params: { email: 'test@example.com',
                                        page: 4,
                                        per: 15 }

        expect(response).to have_http_status(:ok)

        expect(Person).to have_received(:where).with(email: 'test@example.com')
        expect(ar_double).to have_received(:page).with('4')
        expect(ar_double).to have_received(:per).with('15')
      end
    end

    context 'with invalid email address' do
      it 'returns :bad_request with error'
    end
  end
end
