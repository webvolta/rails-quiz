class Api::ApiController < ActionController::API
  private

  def render_query(klass)
    query = initialize_query(klass)
    render json: query.call
  end

  def initialize_query(klass)
    klass.new(filters: filter_params(klass), paging: paging_params)
  end

  def paging_params
    params.permit(:page, :per_page)
  end

  def filter_params(klass)
    params.permit(klass::FILTERS)
  end
end
