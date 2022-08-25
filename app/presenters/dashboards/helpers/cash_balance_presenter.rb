module Dashboards
  module Helpers
    module CashBalancePresenter
      def set_data_cash_balances
        @data_cash_balances = []
        @total_cash = 0.to_money      
        category_range_date.map do |date|
          dates = [dates] if dates.is_a? String
          dates = (date.first.to_date..date.last.to_date).to_a
          journals = Journal.where(code: "1-10001", date: dates, company_id: @current_company.id)

          total = journals.map(&:debit_idr).sum - journals.map(&:credit_idr).sum
          @data_cash_balances << total.to_i
          @total_cash += total.to_money
        end
      end
      
      def cash_balances
        {
          series: [{name: "Cash",data: @data_cash_balances}].to_json,
          categories: categories.to_json
        }
      end
    end
  end
end