# frozen_string_literal: true

module Companies
  class UpdateService < BaseService
    def initialize params
      @params = params      
    end

    def run
      company = Company.find_by(id: @params[:id])
      company.assign_attributes(company_params)

      user = company.users.find_by(email: user_params[:email])
      user.assign_attributes(user_params)

      user.save!
      company.save!
    end

    def company_params
      @params.require(:company).permit(:name, :codename, :slug, :address)      
    end

    def user_params
      @params.require(:user).permit(:email, :password)
    end
  end
end
