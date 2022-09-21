class Api::V1::CompaniesController < Api::V1::BaseController
  include ApiAuthenticable

  skip_before_action :verify_authenticity_token

  def create
    companies = Company.create(companies_attributes)
    if authenticate_user && companies
      render json: companies, each_serializer: CompanySerializer
    else
      render json: { message: 'Invalid email or password' }
    end
  end

  private
    def companies_attributes
      params.permit(companies: [:name]).require(:companies)
    end
end
