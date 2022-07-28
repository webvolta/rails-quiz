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
    end
  end
end
