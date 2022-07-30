class CompanyController < ApplicationController
    def index
        @companies = Company.all
    end
    
    def new
        @company = Company.new
    end
    
    def create
        if Company.create(company_attributes).valid?
          redirect_to company_index_path, notice: 'Successfully created entry'
        else
          redirect_to company_index_path, alert: 'Unsuccessfully created entry'
        end
    end  
      

    ### COMPANY API SECTION ###

    #Get a list of companies based off of filter. :name :page :per_page
    #Results must be case insensitve and partial match
    def company_list
        #Get a list of all companies who have a partial name match, case insensitive and return the results
        @companies = Company.where("lower(name) LIKE ?", "%" + params[:name].downcase + "%").page(params[:page]).per(params[:per_page])

        render json: @companies
    end

    #Add companies to the database
    def company_add
        #Basic Authentication -> Will need upgraded to something like Devise

        if params[:username] == "AcceptedUser" and params[:password] == "AcceptedPassword"
            #User authenticated. Add new companies and return the results
            companies = Company.create(companies_attributes)

            render json: @companies
        else
            #User authntication failed. Return an error message
            render json: {msg: "Invalid username or password"}
        end
    end
    ### END PEOPLE API SECTION ###

    private

    def company_attributes
        params.require(:company).permit(:name)
    end

    def companies_attributes
        params.permit(companies: [:name]).require(:companies)
    end
end
