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

    it 'missing parameters raises an error' do
      post :create, params:{ person: {name: nil, phone_number: nil, email: nil}}
      expect(flash[:alert]).to match("Unsuccessfully created entry")
    end
  end

  describe 'GET people_list' do
    before do
      Person.create(name: 'foo', phone_number: '123', email: 'foo@foo.com')
      Person.create(name: 'foo2', phone_number: '123', email: 'foo2@foo.com')
      Person.create(name: 'foo3', phone_number: '123', email: 'foo2@foo.com')
    end

    it 'Gets a list of people with email foo@foo.com, page, people per page' do
      get :people_list, params: {email: 'foo@foo.com', page: 1, per_page: 10}
      json_resp = JSON(response.body)
      expect(json_resp.count).to eq(1)
    end

    it 'Gets a list of people with email foo2@foo.com, page, people per page' do
      get :people_list, params: {email: 'foo2@foo.com', page: 1, per_page: 10}
      json_resp = JSON(response.body)
      expect(json_resp.count).to eq(2)
    end
  end
end
