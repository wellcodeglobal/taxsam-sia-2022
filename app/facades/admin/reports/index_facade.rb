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
        
        def add_category_report report_line
          {
            name: report_line.name,
            value: "",
            styles: "background-color: antiquewhite;"
          }
        end

        def add_component_report report_line                    
          value = eval(formula_component_parser(report_line))
          {
            name: report_line.name,
            value: value,
            styles: ""
          }
        end

        def add_accumulation_report report_line                    
          value = eval(formula_accumulation_parser(report_line))          
          {
            name: report_line.name,
            value: value,
            styles: "background-color: gray;"
          }
        end      

        def formula_component_parser report_line
          journal_lines = get_journal_lines(report_line.codes)
          debit_sum_idr = journal_lines.sum(&:debit_idr)
          credit_sum_idr = journal_lines.sum(&:credit_idr)

          formula = report_line.formula
            .gsub("${debit}", "#{debit_sum_idr.to_i}")
            .gsub("${credit}", "#{credit_sum_idr.to_i}")

          return formula
        end

        def formula_accumulation_parser report_line
          values_formula = {}
          enum_formula = report_line.formula.gsub(/\${.*?}/)
          enum_formula.each do |formula_key|          
            values_formula[formula_key] = get_values_formula(formula_key)
          end

          formula = report_line.formula
          values_formula.each do |key, value|
            formula = formula.gsub(key, "#{value.to_f}")
          end

          return formula
        end

        def get_values_formula formula_key
          filtered_formula_key = formula_key.gsub("${", "").gsub("}", "")
          filtered_formula_keys = @table_reports.select do |table_report| 
            table_report[:name] == filtered_formula_key
          end.uniq

          return filtered_formula_keys.sum {|table_report| table_report[:value].to_money}
        end

        def get_journal_lines codes
          Journal.where(code: codes)
        end
    end
  end
end
