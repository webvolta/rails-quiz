class CompanyController < ApplicationController
    def create_multiple
        names = params["companies"]
        result = []

        result = names.map { |name| Company.create(:name => name) }

        render :json => result.to_json
    end

    private
end