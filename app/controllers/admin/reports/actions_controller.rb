# frozen_string_literal: true

module Admin
  module Reports
    class ActionsController < Admin::ReportsController
      def import
        if !parser_service.run
          return redirect_to admin_reports_path, 
            alert: parser_service.error_messages.join('<br/>')
        end

        redirect_to admin_reports_path, notice: 'File Berhasil di import'
      end

      def export
        @report = Report.find_by(id: params[:id])
        return redirect_to admin_reports_path, alert: 'Laporan tidak ditemukan.' if @report.blank?        
        @report_facede = Admin::Reports::IndexFacade.new(params)
        respond_to do |format|
          format.xlsx {
            response.headers['Content-Disposition'] = "attachment; filename=\"Laporan #{@report.name}.xlsx\""
          }
        end
      end

      private
      def parser_service        
        @parser_service ||= ::Reports::ParserService.new(
          params[:file],
          current_user.company.id
        )
      end

    end
  end
end
