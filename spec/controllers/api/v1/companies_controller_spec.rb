require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do  subject { response }
  let(:default_headers) do
    {
      'Content-Type' => 'application/json',
      'Accept'       => 'application/json'
    }
  end

  let(:company) { create(:company) }

  context '#index' do
    it 'should return success' do
      request.headers.merge!(default_headers)

      get :index
      expect(response).to be_successful
    end
  end

  describe 'POST create companies' do
    it 'Creates new companies with basic authentication' do
      expect{ post :create, params: { email: 'example@test.com', password: '123456', companies: [{ name: 'Foo Bar, Inc' }] }}.to change{ Company.count }.by(1)
    end

    it 'does not create new company due to invalid email or password' do
      post :create, params: {companies: [{name: "Foo Bar, Inc'"}]}
      response_data = JSON(response.body)

      expect(response_data['message']).to eq('Invalid email or password')
    end
  end
end
