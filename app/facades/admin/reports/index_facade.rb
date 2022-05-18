# frozen_string_literal: true

module Admin
  module Reports    
    class IndexFacade
      def initialize params
        @params = params
        @table_reports = []   
        table_report_generator
      end

      def table_reports
        @table_reports
      end

      def report
        @report ||= Report.find(@params[:id])
      end

      private
        def add_category_report report_line
          {
            name: report_line.name,
            code: report_line.codes.join(', '),
            value: "",
            styles: "background-color: antiquewhite;"
          }
        end

        def add_component_report report_line          
          journal_lines = get_journal_lines(report_line.codes)
          debit_sum_idr = journal_lines.sum(&:debit_idr)
          credit_sum_idr = journal_lines.sum(&:credit_idr)

          formula = report_line.formula
            .gsub("${debit}", "#{debit_sum_idr.to_i}")
            .gsub("${credit}", "#{credit_sum_idr.to_i}")

          value = eval(formula)
          {
            name: report_line.name,
            code: report_line.codes.join(', '),
            value: value,
            styles: ""
          }
        end

        def add_accumulation_report report_line
          value = 0
          {
            name: report_line.name,
            code: report_line.codes.join(', '),
            value: value,
            styles: "background-color: gray;"
          }
        end      

        def table_report_generator
          report.report_lines.each do |report_line|
            if report_line.category?
              @table_reports << add_category_report(report_line)
            elsif report_line.component?
              @table_reports << add_component_report(report_line)
            else report_line.accumulation?
              @table_reports << add_accumulation_report(report_line)
            end
          end
        end

        def get_journal_lines codes
          Journal.where(code: codes)
        end
    end
  end
end
