class Api::CompaniesController < Api::ApiController
  def index
    render_query CompanyQuery
  end
end