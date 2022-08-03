class CompaniesController < ApplicationController

    def index
        @companies = Company.all.page params[:page]
    
      end
    
      def new
        @company = Company.new
      end  

      def create
    
        @company = Company.new(company_attributes)
    
        if Company.create(company_attributes)
          redirect_to companies_path, notice: 'Successfully created entry'
        else
          render :create, alert: 'Unsuccessfully created entry'
        end
      end

      def edit
        @company = Company.find(params[:id])
      end   

      def update
        @company = Company.find(params[:id])
       
      if @company.update(company_params)
          redirect_to company_path
          flash[:success] = "company updated!"
        else
          flash.now[:danger] = "Something went wrong"
          render :edit
        end    
      end
    
      private
    
      def company_attributes
        params.require(:company).permit(:name)
      end
         
 end
