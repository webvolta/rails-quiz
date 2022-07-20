# frozen_string_literal: true

# Class that handles the creation companies
class CompaniesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret', only: :create_multiple_companies

  def index
    @companies = Company.page params[:page]
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_attributes)
    if @company.save
      redirect_to companies_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  def create_multiple_companies
    if @companies = Company.create(multiple_company_attributes[:companies])
      render json: {
        data: @companies
      }, status: :created
    else
      render json: {
        errors: @companies.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def search_company
    @companies = Company.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(params[:per_page]) if params[:name].present?
    return render json: {}, status: 404 if @companies.empty?

    render json: {
      data: @companies,
      meta: { page: @companies.current_page,
              per: params[:per_page] || 10 }
    }
  end

  private

  def company_attributes
    params.require(:companies).permit(:name)
  end

  def multiple_company_attributes
    params.permit(companies: [:name])
  end
end
