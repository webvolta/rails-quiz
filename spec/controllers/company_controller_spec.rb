require 'rails_helper'

RSpec.describe CompanyController, type: :controller do
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
      expect{ post :create, params: { company: { name: 'foo'} } }.to change{ Company.count }.by(1)
    end

    it 'has status found' do
      expect(post :create, params: { company: { name: 'foo'} }).to have_http_status(:found)
    end

    it 'missing parameters raises an error' do
      post :create, params:{ company: {name: nil}}
      expect(flash[:alert]).to match("Unsuccessfully created entry")
    end
  end

  describe 'GET company_list' do
    before do
      Company.create(name: 'acme')
      Company.create(name: 'acme foo')
      Company.create(name: 'acme foo bar')
    end

    it 'Gets a list of companies by partial, case insensitive name Acme, page, people per page' do
      get :company_list, params: {name: 'Acme', page: 1, per_page: 10}
      json_resp = JSON(response.body)
      expect(json_resp.count).to eq(3)
    end
    
    it 'Gets a list of companies by partial, case insenstive name FoO, page, companies per page' do
      get :company_list, params: {name: 'FoO', page: 1, per_page: 10}
      json_resp = JSON(response.body)
      expect(json_resp.count).to eq(2)
    end
  end

  describe 'POST company_add' do
    it 'Adds 1 new company with basic authentication' do
      expect{ post :company_add, params: { username: "AcceptedUser", password: "AcceptedPassword", companies: [{ name: 'Foo Bar, Inc' }] }}.to change{ Company.count }.by(1)
    end

    it 'Adds 3 new companies with basic authentication' do
      expect{ post :company_add, params: { username: "AcceptedUser", password: "AcceptedPassword", companies: [{ name: 'Foo Bar, Inc' },{name: 'Acme, Inc'}, {name: 'New Store'}] }}.to change{ Company.count }.by(3)
    end

    it 'Fails with invalid username or password' do
      post :company_add, params: {companies: [{name: "Foo Bar, Inc'"}]}
      json_resp = JSON(response.body)
      expect(json_resp["msg"]).to eq("Invalid username or password")
    end
  end
end
