class PeopleController < ApplicationController
  def index
    page = params[:page].to_i
    page = 1 if page == 0
    @people = People::List.new(page: page).execute
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_attributes)
    if @person.save
      redirect_to people_path, notice: 'Successfully created entry'
    else
      render :new, alert: 'Unsuccessfully created entry', status: :unprocessable_entity
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end
end
