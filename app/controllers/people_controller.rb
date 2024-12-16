class PeopleController < ApplicationController

  def index
    @people = Person.includes(:company).page(params[:page] || 1).per(10)
  end

  def new
    @person = Person.new
    @companies = Company.all.order(:name)
  end

  def create
    @person = Person.new(person_attributes)

    if @person.save
      redirect_to people_path, notice: 'Person successfully created'
    else
      @companies = Company.page(params[:page] || 1).per(10)
      render :new
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number, :company_id)
  end
end

