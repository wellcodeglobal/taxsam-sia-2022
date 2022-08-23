module Dashboards
  class IndexPresenter < BasePresenter
    def initialize start_date, end_date
      @params_start_date = start_date
      @params_end_date = end_date

      set_data_cash_balances
      set_data_bank_accounts
    end

    def set_data_cash_balances
      @data_cash_balances = []
      @total_cash = 0.to_money      
      category_range_date.map do |date|
        dates = [dates] if dates.is_a? String
        dates = (date.first.to_date..date.last.to_date).to_a
        journals = Journal.where(code: "1-10001", date: dates)

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

    def set_data_bank_accounts
      @data_bank_accounts = []      
      @total_bank_account = 0.to_money
      category_range_date.map do |date|
        dates = [dates] if dates.is_a? String
        dates = (date.first.to_date..date.last.to_date).to_a
        journals = Journal.where(code: "1-10002", date: dates)

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