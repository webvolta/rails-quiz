module Api
  module V1
    class CompaniesController < ApplicationController

      def index
        if params[:name]
          @companies = Company.search_by_name(params[:name])
            .page(params[:page])
            .per(params[:per])
        else
          @companies = Company.page(params[:page]).per(params[:per])
        end

        render json: @companies
      end

      def create
        if params[:companies]
          attributes = companies_params[:companies]
        else
          attributes = company_params
        end

        @company = Company.create(attributes)

        if @company.valid?
          render json: @company, status: :created
        else
          render json: @company.errors.full_messages,
                 status: :unprocessable_entity
        end
      end

      private

      def company_params
        params.require(:company).permit(:name)
      end

      def companies_params
        params.permit(companies: [:name])
      end
    end
  end
end
