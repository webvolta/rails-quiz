require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do  subject { response }
  let(:default_headers) do
    {
      'Content-Type' => 'application/json',
      'Accept'       => 'application/json'
    }
  end

  let(:person) { create(:person) }

  context '#index' do
    it 'should return success' do
      request.headers.merge!(default_headers)

      get :index
      expect(response).to be_successful
    end
  end
end
