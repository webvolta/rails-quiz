class Api::V1::CompanyController < ApplicationController
    include Pagination

    def index
        if params[:name] && params[:page] && params[:per_page]
            @company = Company.where(:name => params[:name])
            render json: @company.then(&paginate)
        elsif params[:page] && params[:per_page]
            @company = Company.all
            render json: @company.then(&paginate)
        elsif params[:name]
            @company = Company.where(:name => params[:name])
            render json: @company
        else
            @company = Company.all
            render json: @company
        end
    end
end
