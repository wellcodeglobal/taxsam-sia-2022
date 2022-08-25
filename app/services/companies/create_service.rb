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
      
      populate_data(new_company)
    end

    def company_params
      @params.require(:company).permit(:name, :codename, :slug, :address)      
    end

    def user_params
      @params.require(:user).permit(:email, :password)
    end

    def populate_data new_company
      company_resource = Company.find_by(slug: "txsm")
      accounts = company_resource.accounts
      reports = company_resource.reports
      
      accounts.each do |account| 
        new_account = new_company.accounts.new(account.dup.as_json.except("id", "company_id"))
        new_account.save
      end

      reports.each do |report|
        new_report = new_company.reports.new(report.dup.as_json.except("id", "company_id"))
        new_report.save

        report.report_lines.each do |report_line|
          new_report_line = new_report.report_lines.new(report_line.as_json.except("id", "company_id"))
          new_report_line.save
        end
      end
    end
  end
end
