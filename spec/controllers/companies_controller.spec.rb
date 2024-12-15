require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:company) { FactoryBot.create(:company, name: "Test Company") }

  describe "GET #index" do
    it "assigns @companies with paginated results" do
      get :index, params: { page: 1 }
      expect(assigns(:companies)).to be_a_kind_of(ActiveRecord::Relation)
      expect(assigns(:companies)).to include(company)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "assigns a new Company to @company" do
      get :new
      expect(assigns(:company)).to be_a_new(Company)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "assigns the requested company to @company" do
      get :edit, params: { id: company.id }
      expect(assigns(:company)).to eq(company)
    end

    it "renders the edit template" do
      get :edit, params: { id: company.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new company" do
        expect {
          post :create, params: { company: { name: "New Company" } }
        }.to change(Company, :count).by(1)
      end

      it "redirects to the index with a success notice" do
        post :create, params: { company: { name: "New Company" } }
        expect(response).to redirect_to(companies_path)
        expect(flash[:notice]).to eq("Successfully created entry")
      end
    end

    context "with invalid attributes" do
      it "does not create a new company" do
        expect {
          post :create, params: { company: { name: "" } }
        }.not_to change(Company, :count)
      end

      it "renders the create template with an alert" do
        post :create, params: { company: { name: "" } }
        expect(response).to render_template(:create)
        expect(flash[:alert]).to eq("Unsuccessfully created entry")
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the company" do
        patch :update, params: { id: company.id, company: { name: "Updated Company" } }
        company.reload
        expect(company.name).to eq("Updated Company")
      end

      it "redirects to the index with a success notice" do
        patch :update, params: { id: company.id, company: { name: "Updated Company" } }
        expect(response).to redirect_to(companies_path)
        expect(flash[:notice]).to eq("Successfully updated entry")
      end
    end

    context "with invalid attributes" do
      it "does not update the company" do
        patch :update, params: { id: company.id, company: { name: "" } }
        company.reload
        expect(company.name).to eq("Test Company")
      end

      it "renders the edit template with an alert" do
        patch :update, params: { id: company.id, company: { name: "" } }
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to eq("Unsuccessfully created entry")
      end
    end
  end
end
