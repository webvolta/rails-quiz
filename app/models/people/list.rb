class People::List
  private attr_accessor :page
  def initialize(page:)
    self.page = page
  end

  def execute
    Person.order(:id).page(page).per(10)
  end
end
