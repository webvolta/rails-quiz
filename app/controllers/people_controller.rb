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
      render :new, alert: 'Unsuccessfully created entry'
    end
  end

  def search
    render :index, alert: 'Improper search request' unless valid_search_attribute?  
    
    set_params
    @people = Person.where("email LIKE ?", "%#{@search_email}%").page(@page).per(@per_page)

    render :index, people: @people 
  end

  private

  def set_params
    @search_email = params[:search][:email]
    @page = params[:page]
    @per_page = params[:search][:per_page]
  end

  def valid_search_attribute?
    params.require(:search).permit(:per_page, :email)
    params.permit(:per_page)
  end

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

