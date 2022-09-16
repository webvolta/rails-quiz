class Api::CompaniesController < Api::ApiController
  http_basic_authenticate_with name: ENV.fetch('AUTH_USER'),
                               password: ENV.fetch('AUTH_PASSWORD'),
                               only: :create

  def index
    render_query CompanyQuery
  end

  def create
    render_validated_action(error_message: "Failed to create companies!") do
      Company.create!(create_params)
    end
  end

  private

  def create_params
    params.permit(companies: [:name]).require(:companies)
  end
end