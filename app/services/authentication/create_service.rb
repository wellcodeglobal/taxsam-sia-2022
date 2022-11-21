# frozen_string_literal: true

module Authentication
  class CreateService < BaseService
    def initialize email, params
      @email = email
      @params = params
    end

    def action
      @user = User.find_or_initialize_by(email: @email)
      @user.password = Random.hex(12)
      @user.company = company
      @user.save!
    end

    def user 
      @user
    end

    def company
      name = @params[:name]
      address = @params[:address]
      generated_code = ""

      if name.present?
        generated_code = "#{name[0]}#{name[1..].delete("aeiouAEIOU").first(3)}-#{Random.hex(3)}".parameterize
      end

      new_company = Company.new(
        name: name, 
        codename: generated_code,
        slug: generated_code,
        address: address
      )
      new_company.save!

      company_service = Companies::CreateService.new(@params)
      company_service.populate_data(new_company)
      new_company
    end
  end
end
