class Api::PeopleController < Api::ApiController
  def index
    render_query PersonQuery
  end
end