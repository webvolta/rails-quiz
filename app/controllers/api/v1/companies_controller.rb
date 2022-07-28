module Api
  module V1
    class CompaniesController < ApplicationController
      protect_from_forgery with: :null_session

      http_basic_authenticate_with \
        name: Rails.application.secrets.api_http_auth[:username],
        password: Rails.application.secrets.api_http_auth[:password],
        only: :create

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
          @company = Company.create(companies_params[:companies])
          @errors = @company.map { |e| e.errors.full_messages unless e.valid? }
        else
          @company = Company.create(company_params)
          @errors = @company.valid? ? [] : [@company.errors.full_messages]
        end

        if @errors.any?
          return render json: @errors, status: :unprocessable_entity
        end

        render json: @company, status: :created
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
