class CompaniesController < ApplicationController
  def index
    @companies = Company.page params[:page]
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_attributes)
    if @company.save
      redirect_to companies_path, notice: 'Successfully created entry'
    else
      render :create, alert: 'Unsuccessfully created entry'
    end
  end

  def search_company
    @companies = Company.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(params[:per_page]) if params[:name].present?
    render json: {
      data: @companies,
      meta: { page: @companies.current_page,
              per: params[:per_page] || 10 }
    }
  end

  private

  def company_attributes
    params.require(:company).permit(:name)
  end
end
