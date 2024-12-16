class Api::PeopleController < ActionController::API
  def index
    if params[:email].present?
      people = Person.where(email: params[:email]).page(params[:page] || 1).per(params[:per_page] || 10)
    else
      people = Person.includes(:company).page(params[:page] || 1).per(10)
    end

    render json: { meta: pagination_meta(people), data: people }, status: 200
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
