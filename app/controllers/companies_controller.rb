class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  
  def search
    render :index, alert: 'Improper search request' unless valid_search_attribute?  

    set_params

    @companies = Company.where("lower(name) LIKE ?", "%#{@name}%").page(@page).per(@per_page)

    render :index, companies: @companies 
  end

  private

  def set_params
    @name = params[:search][:name].downcase
    @page = params[:page]
    @per_page = params[:search][:per_page]
  end


  def valid_search_attribute?
    params.require(:search).permit(:per_page, :email)
    params.permit(:per_page)
  end

end
