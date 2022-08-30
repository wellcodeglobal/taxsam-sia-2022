module Dashboards
  module Helpers
    module ProfitLossPresenter
      def set_data_profit_loss
        @data_gross_profit = []
        @data_net_profit = []  
        @report = Report.find_by(name: "Laba Rugi")
        return if @report.blank?

        category_range_date.map do |date|
          dates = [dates] if dates.is_a? String

          params = {
            id: @report.id,
            start_date: date.first.to_date,
            end_date: date.last.to_date
          }

          @report_facede = Admin::Reports::IndexFacade.new(params, @current_company)
          total_gross_profit = @report_facede.table_reports.map {|r| r[:value] if r[:name] == "Total Pendapatan"}.compact.sum
          total_net_profit = @report_facede.table_reports.map {|r| r[:value] if r[:name] == "LABA RUGI"}.compact.sum
          
          @data_gross_profit << total_gross_profit
          @data_net_profit << total_net_profit
        end
      end

      def profit_loss
        {
          series: [
            {
              name: "Laba Kotor",
              type: "column",
              data: @data_gross_profit
            },
            {
              name: "Laba Bersih", 
              type: "column",
              data: @data_net_profit
            }
          ].to_json,
          categories: categories.to_json
        } 
      end
    end
  end
end