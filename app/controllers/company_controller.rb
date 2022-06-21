class CompanyController < ApplicationController
    protect_from_forgery with: :null_session
    
    def create_multiple
        names = params["companies"]
        result = []

        names.each do |name|
            company = Company.create(:name => name)
            result.push(company)
        end

        render :json => result.to_json
    end

    private
end