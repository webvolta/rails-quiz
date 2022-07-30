class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    if Person.create(person_attributes).valid?
      redirect_to people_path, notice: 'Successfully created entry'
    else
      redirect_to people_path, alert: 'Unsuccessfully created entry'
    end
  end

  ### PEOPLE API SECTION ###

  #Get a list of people based off of filter. :email :page :per_page
  def people_list
    #Get a list of all people who have the email provided based on page, limited by per_page
    @people = Person.where("email = ?", params[:email]).page(params[:page]).per(params[:per_page])

    render json: @people
  end

  ### END PEOPLE API SECTION ###
  
  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

