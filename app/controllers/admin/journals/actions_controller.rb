# frozen_string_literal: true

module Admin
  module Journals
    class ActionsController < Admin::JournalsController
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

    end
  end
end
