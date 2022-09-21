class CompaniesController < ApplicationController
	before_action :set_company, only: %i[ show edit update ]
  skip_before_action :verify_authenticity_token, only: %i[ create update ]  

	def index
		@companies = Company.where('name like ?', "%#{params[:name]}%").page(params[:page]).per(params[:per_page])
		
		respond_to do |format|
			format.html
			format.json { render json: @companies, each_serializer: CompanySerializer }
		end
	end
	
	def new
		@company = Company.new
	end
	
	def edit
	end
	
	def create
		@company = Company.new(company_params)

		respond_to do |format|
			if @company.save
				format.html { redirect_to company_url(@company), notice: 'Company was successfully created.' }
				format.json { render json: @company, serializer: CompanySerializer }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @company.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def update
		respond_to do |format|
			if @company.update(company_params)
				format.html { redirect_to companies_url, notice: 'Company name is successfully changed.' }
				format.json { render json: @company, serializer: CompanySerializer }
			else
				format.html { redirect_to companies_url, notice: 'Company not updated.' }
				format.json { render json: @company.errors, status: :unprocessable_entity }
			end
		end
	end

	private
		def set_company
			@company = Company.find(params[:id])
		end

		def company_params
			params.require(:company).permit(:name)
		end
end