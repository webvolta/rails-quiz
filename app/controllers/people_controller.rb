# frozen_string_literal: true

class PeopleController < ApplicationController
  def index
    @people = Person.page params[:page]
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_attributes)
    if @person.save
      redirect_to people_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  def search
    @people = Person.where(email: params[:email]).page(params[:page]).per(params[:per_page]) if params[:email].present?
    render json: {
      data: @people,
      meta: { page: @people.current_page,
              per: params[:per_page] || 10 }
    }
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end
end
