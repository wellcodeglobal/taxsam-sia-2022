module Dashboards
  module Helpers
    module CashInOutPresenter
      def set_data_cash_in_out
        @data_cash_in = []
        @data_cash_out = []
        @data_cash_net = []        
        @report = Report.find_by(name: "Laba Rugi")
        return if @report.blank?

        category_range_date.map do |date|
          dates = [dates] if dates.is_a? String

          params = {
            id: @report.id,
            start_date: date.first.to_date,
            end_date: date.last.to_date
          }

          @report_facede = Admin::Reports::IndexFacade.new(params, current_company)
          total_cash_in = @report_facede.table_reports.map {|r| r[:value] if r[:name] == "Total Pendapatan"}.compact.sum
          total_cash_out = @report_facede.table_reports.map {|r| r[:value] if r[:name] == "Total Beban Operasional"}.compact.sum
          
          @data_cash_in << total_cash_in
          @data_cash_out << total_cash_out
          @data_cash_net << total_cash_in - total_cash_out
        end
      end
  
      def cash_in_out
        {
          series: [
            {
              name: "In", 
              type: "column",
              data: @data_cash_in
            },
            {
              name: "Out", 
              type: "column",
              data: @data_cash_out
            },
            {
              name: "Net", 
              type: "line",
              data: @data_cash_net
            }
          ].to_json,
          categories: categories.to_json
        }
      end
    end
  end
end