require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST create' do
    let(:base_params) do
      {
      person: {
        name: 'foo',
        email: 'foo',
        phone_number: '123'
        
      }
    }
    end 

    context 'with valid params' do

      it 'creates a new record' do
        expect{ post :create, params: base_params}.to change{ Person.count }.by(1)
      end
    end
    
    it 'has status found' do
      expect(post :create, params: base_params).to have_http_status(:found)
    end
    # it 'has status found' do
      # expect(post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } }).to have_http_status(:found)
    # end
  end
end
