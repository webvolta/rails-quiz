class Api::V1::PeopleController < ApplicationController
    include Pagination
    
    def index
        if params[:email] && params[:page] && params[:per_page]
            @person = Person.where(:email => params[:email])
            render json: @person.then(&paginate)
        elsif params[:page] && params[:per_page]
            @person = Person.all
            render json: @person.then(&paginate)
        elsif params[:email]
            @person = Person.where(:email => params[:email])
            render json: @person
        else
            @person = Person.all
            render json: @person
        end
    end
end
