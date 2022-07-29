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

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

