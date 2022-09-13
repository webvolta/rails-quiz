class Api::V1::PeopleController < Api::V1::BaseController

  def index
    people = Person.where('email like ?', "%#{params[:email]}%").page(params[:page]).per(params[:per_page])
    render json: people, each_serializer: PersonSerializer
  end
end

