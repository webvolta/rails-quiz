module Api
  module V1
    class PeopleController < ApplicationController

      def index
        if params[:email]
          @people = Person.where(email: params[:email])
            .page(params[:page])
            .per(params[:per])
        else
          @people = Person.page(params[:page]).per(params[:page])
        end

        render json: @people
      end
    end
  end
end
