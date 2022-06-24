# frozen_string_literal: true

module Journals
  class ParserService < Journals::BaseService
    FIELD_MAP = {
      :date => 7,
      :no_evidence => 8,
      :description => 9,
      :code => 10,
      :name => 11,
      :company_name => 12,
      :debit => 13,
      :credit => 14
    }
    
    def action
      @saved_transaction = []      
      sheet.each_with_index do |row, i|                
        next if i < 8
        @raw_row = { index: i,row: row }        
        @row = OpenStruct.new(
          FIELD_MAP.map {|key,val| [key, row[val]]}.to_h
        )
        
        if !is_row_valid?
          @saved_transaction << nil 
          next
        end
        
        init_general_transaction
        parse_and_save

        @saved_transaction << @general_transaction
      end
    end

    def sheet
      @sheet ||= xlsx.sheet("Jurnal Umum")
    end

    def is_row_valid?
      return false if @row.name.blank?
      return false if @row.code.blank?
      true
    end

    def init_general_transaction
      return @general_transaction unless @saved_transaction.last.nil?
      if @row.date.blank?
        @error_messages << "Terdapat Tanggal Tidak di isi Untuk data baris ke-: #{@raw_row[:index] + 1}."
        @error_messages << "Detail record: #{@raw_row[:row]}."
        raise
      end

      @general_transaction = GeneralTransaction.find_or_initialize_by(
        number_evidence: @row.no_evidence,
        company_id: @company_id
      )
      @general_transaction.date = @row.date.to_date      
    end

    def parse_and_save
      general_transaction_line = @general_transaction.general_transaction_lines.find_by(
        code: @row.code,
        description: @row.description,
        company_id: @company_id
      )

      if general_transaction_line.blank?
        general_transaction_line = @general_transaction.general_transaction_lines.new(
          code: @row.code,
          description: @row.description,
          company_id: @company_id
        )
      end

      general_transaction_line.debit_idr = @row.debit.to_money
      general_transaction_line.credit_idr = @row.credit.to_money

      @general_transaction.save!
    end
  end
end
