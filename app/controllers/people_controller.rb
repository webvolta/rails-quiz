class PeopleController < ApplicationController

  def index
    @people = Person.includes(:company).limit(100).page params[:page] #change limit to adjust total DB query size default @100

  end

  def new
    @person = Person.new
  end



  def create

    @person = Person.new(person_attributes)

    if @person.email != @person.email_check 
      redirect_to new_person_path, notice: 'Please double check your email!'
      return
    end

    if Person.create(person_attributes)
      redirect_to people_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :email_check, :phone)
  end

end

