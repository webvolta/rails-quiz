class CompaniesController < ApplicationController
  before_action :load_company, only: [:edit, :update]

  def index
    @companies = Company.all.page(params[:page] || 1).per(10)
  end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    if Company.create(company_attributes)
      redirect_to companies_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  def update
    if @company.update(company_attributes)
      redirect_to companies_path, notice: 'Successfully updated entry'
    else
      render :edit, alert: 'Unsuccessfully created entry'
    end
  end

  private

  def company_attributes
    params.require(:company).permit(:name)
  end

  def load_company
    @company = Company.find(params[:id])
  end
end

