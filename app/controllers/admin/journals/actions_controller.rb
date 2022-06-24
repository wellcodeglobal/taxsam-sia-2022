# frozen_string_literal: true

module Admin
  module Journals
    class ActionsController < Admin::JournalsController
      def export
        @journals = Journal.where(date: date_range)
        respond_to do |format|
          format.xlsx {
            response.headers['Content-Disposition'] = "attachment; filename=\"Journals.xlsx\""
          }
        end
      end

      def import
        if !parser_service.run
          return redirect_to admin_journals_path, 
            alert: parser_service.error_messages.join('<br/>')
        end

        redirect_to admin_journals_path, notice: 'File Berhasil di import'
      end

      def download_template
        send_file(
          "#{Rails.root}/public/template_journal.xlsx",
          filename: 'template_journal.xlsx',
          type: 'application/xlsx'
        )
      end

      private
      def parser_service        
        @parser_service ||= ::Journals::ParserService.new(
          params[:file],
          current_user.company.id
        )
      end

      def date_range
        if params[:start_date].present? && params[:end_date].present?
          return (params[:start_date].to_date..params[:end_date].to_date)
        end
        return (Date.today.beginning_of_year..Date.today.end_of_month)
      end

    end
  end
end
