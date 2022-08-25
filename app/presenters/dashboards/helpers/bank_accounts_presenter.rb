module Dashboards
  module Helpers
    module BankAccountsPresenter
      def set_data_bank_accounts
        @data_bank_accounts = []      
        @total_bank_account = 0.to_money
        category_range_date.map do |date|
          dates = [dates] if dates.is_a? String
          dates = (date.first.to_date..date.last.to_date).to_a
          journals = Journal.where(code: "1-10002", date: dates, company_id: @current_company.id)

          total = journals.map(&:debit_idr).sum - journals.map(&:credit_idr).sum
          @data_bank_accounts << total.to_i
          @total_bank_account += total.to_money
        end
      end

      def bank_accounts
        {
          series: [{name: "Bank Account",data: @data_bank_accounts}].to_json,
          categories: categories.to_json
        }
      end

      def total_cash
        @total_cash
      end

      def total_bank_account
        @total_bank_account
      end
    end
  end
end