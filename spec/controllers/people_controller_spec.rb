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
    it 'Creates a record' do
      expect{ post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } } }.to change{ Person.count }.by(1)
    end

    it 'has status found' do
      expect(post :create, params: { person: { name: 'foo', phone_number: '123', email: 'foo' } }).to have_http_status(:found)
    end

    it 'doesn\'t create a user when is missing phone_number' do
      expect(post :create, params: { person: { name: 'foo', email: 'foo' } }).to have_http_status(:unprocessable_entity)
    end
  end
end
