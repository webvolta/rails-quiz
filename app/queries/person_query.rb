class PersonQuery
  include BaseQuery

  FILTERS = [:email].freeze

  def initialize(filters: {}, paging: {})
    @scope = Person.order(:name)
    @scope = @scope.where(email: filters[:email]) if filters[:email]
    @scope = apply_paging(@scope, paging)
  end
end