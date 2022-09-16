module BaseQuery
  extend ActiveSupport::Concern

  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def call
    @scope
  end

  private

  def apply_paging(scope, paging)
    page = normalize_param(paging, :page, DEFAULT_PAGE)
    per_page = normalize_param(paging, :per_page, DEFAULT_PER_PAGE)
    scope.page(page).per(per_page)
  end

  def normalize_param(paging, param_name, default_value)
    value = paging[param_name].to_i
    if value <= 0
      default_value
    else
      value
    end
  end
end