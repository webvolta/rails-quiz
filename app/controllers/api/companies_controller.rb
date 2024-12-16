class Api::CompaniesController < ActionController::API
  def index
    if params[:name].present?
      companies = Company.where('LOWER(name) LIKE ?', "%#{params[:name]&.downcase}%").page(params[:page] || 1).per(params[:per_page] || 10)
    else
      companies = Company.all.page(params[:page] || 1).per(10)
    end

    render json: { meta: pagination_meta(companies), data: companies }, status: 200
  end

  private

  def pagination_meta(scope)
    {
      current_page: scope.current_page,
      next_page: scope.next_page,
      prev_page: scope.prev_page,
      total_pages: scope.total_pages,
      total_count: scope.total_count
    }
  end
end
