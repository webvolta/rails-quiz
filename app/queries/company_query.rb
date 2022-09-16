class CompanyQuery
  include BaseQuery

  FILTERS = [:name].freeze

  def initialize(filters: {}, paging: {})
    @scope = Company.order(:name)
    @scope = @scope.by_name_like(filters[:name]) if filters[:name]
    @scope = apply_paging(@scope, paging)
  end
end