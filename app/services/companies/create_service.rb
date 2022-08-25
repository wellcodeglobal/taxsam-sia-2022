# frozen_string_literal: true

module Companies
  class CreateService < BaseService
    def initialize params
      @params = params
    end

    def run
      new_company = Company.new(company_params)      
      new_user = new_company.users.new(user_params)

      new_company.save!
    end

    def company_params
      @params.require(:company).permit(:name, :codename, :slug, :address)      
    end

    def user_params
      @params.require(:user).permit(:email, :password)
    end
  end
end
