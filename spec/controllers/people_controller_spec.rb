require 'rails_helper'

def create_people_with_companies(count)
  count.times do |i|
    company = Company.create!(name: "Company #{i}")
    Person.create!(name: "Person #{i}", email: "person#{i}@example.com", phone_number: "123456789#{i}", company: company)
  end
end

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }

    context "when there are many people to list" do
      before do
        create_people_with_companies(25) # Creates 25 people with associated companies
      end

      it "assigns @people with paginated results" do
        get :index, params: { page: 1 }
        expect(assigns(:people)).to be_a_kind_of(ActiveRecord::Relation)
        expect(assigns(:people).count).to eq(10) # Expect 10 items per page
      end

      it "renders the index template" do
        get :index, params: { page: 1 }
        expect(response).to render_template(:index)
      end

      it "paginates correctly for the first page" do
        get :index, params: { page: 1 }
        expect(assigns(:people).first.name).to eq("Person 0")
        expect(assigns(:people).last.name).to eq("Person 9")
      end

      it "paginates correctly for the second page" do
        get :index, params: { page: 2 }
        expect(assigns(:people).first.name).to eq("Person 10")
        expect(assigns(:people).last.name).to eq("Person 19")
      end

      it "defaults to the first page if no page param is given" do
        get :index
        expect(assigns(:people).first.name).to eq("Person 0")
        expect(assigns(:people).last.name).to eq("Person 9")
      end
    end
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
  end
end
