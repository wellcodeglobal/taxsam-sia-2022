# frozen_string_literal: true

module Admin
  module Settings
    class CompanyProfilesController < Admin::ReportsController
      def index
      end

      def create
        current_company.update(company_params)
        redirect_to admin_settings_path, notice: 'Company profile was successfully updated.'
      end

      private
      def company_params
        params.require(:company).permit(:name, :codename, :slug, :address)
      end
    end
  end
end