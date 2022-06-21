class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    if Person.create(person_attributes)
      redirect_to people_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  def search_by_email
    result = Person.where(email: params['email']).paginate(page: params[:page], per_page: params[:per_page])
    render :json => result.to_json
  end

  def search_by_name
    result = Person.where("UPPER(name) like ?", "%" + Person.sanitize_sql_like(params['name']) + "%").paginate(page: params[:page], per_page: params[:per_page])
    render :json => result.to_json
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end
end

