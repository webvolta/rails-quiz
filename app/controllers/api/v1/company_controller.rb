class Api::V1::CompanyController < ApplicationController
  def show
    company = company.find_by(name: params[:name]).page params[:page]

    if company
      render json: company, status: 200
    else
      render json: {error: "Company Not Found."}
    end
  end

  private

  def company_attributes
    params.require(:company).permit(:name)
  end

end
