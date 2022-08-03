class Api::V1::PeopleController < ApplicationController
 
  def show
    person = Person.find_by(email: params[:email]).page params[:page]

    if person
      render json: person, status: 200
    else
      render json: {error: "Person Not Found."}
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone)
  end

end
