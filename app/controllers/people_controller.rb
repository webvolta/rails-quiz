class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    if Person.create({
      name: person_attributes[:name], 
      phone_number: person_attributes[:phone_number], 
      email: person_attributes[:email], 
      company: Company.create(name: person_attributes[:company])})
      redirect_to people_path, notice: 'Successfully created entry'
    else 
      render :new, alert: 'Unsuccessfully created entry'
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number, :company)
  end

end

