module Dashboards
  class IndexPresenter
    def initialize start_date, end_date
      @params_start_date = start_date
      @params_end_date = end_date
    end

    def date_range
      @date_range ||= start_date..end_date
    end

    def start_date
      @start_date ||= begin
        unless @params_start_date.present?
          return @start_date = DateTime.now.beginning_of_year
        end
        @start_date = Date.strptime(@params_start_date, '%d/%m/%Y')
      end
    end

    def end_date
      @end_date ||= begin
        unless @params_end_date.present?
          return @end_date = DateTime.now.end_of_month.end_of_day
        end
        @end_date = Date.strptime(@params_end_date, '%d/%m/%Y')
      end
    end

    def categories
      return @categories if @categories.present?

      @category_range_date = []

      if date_range.count > 31
        date_range.to_a.group_by {|date| date.beginning_of_month}.keys.each do |beginning_date|
          @category_range_date << (beginning_date..beginning_date.end_of_month).to_a
        end

        return @categories = @category_range_date.map(&:first).map do |date|
          I18n.t("date.month_names")[date.to_date.month].first(3)
        end.uniq
      end

      if date_range.count > 7
        date_range.each_slice(3) do |w_days|
          w_days.compact!
          @category_range_date << (w_days.first.to_date..w_days.last.to_date).to_a
        end

        return @categories = @category_range_date.map(&:first).map do |date|
          date.to_date.strftime("%d/%m/%Y")
        end.uniq
      end

      @category_range_date = date_range.to_a.map do |date|
        date.to_date.strftime("%d/%m/%Y")
      end.uniq

      @categories = @category_range_date
    end

    def category_range_date
      categories if @category_range_date.blank?
      @category_range_date
    end

    def cash_balances
      data_cash_balances = []
      category_range_date.map do |date|
        dates = [dates] if dates.is_a? String
        dates = (date.first.to_date..date.last.to_date).to_a
        journals = Journal.where(code: "1-10001", date: dates)
        data_cash_balances << journals.map(&:debit_idr).sum - journals.map(&:credit_idr).sum
      end

      {
        series: [{name: "Cash",data: data_cash_balances}].to_json,
        categories: categories.to_json
      }
    end

    def bank_accounts
      data_bank_accounts = []
      category_range_date.map do |date|
        dates = [dates] if dates.is_a? String
        dates = (date.first.to_date..date.last.to_date).to_a
        journals = Journal.where(code: "1-10002", date: dates)
        data_bank_accounts << journals.map(&:debit_idr).sum - journals.map(&:credit_idr).sum
      end

      {
        series: [{name: "Bank Account",data: data_bank_accounts}].to_json,
        categories: categories.to_json
      }
    end

  end
end