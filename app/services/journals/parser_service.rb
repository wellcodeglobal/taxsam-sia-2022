# frozen_string_literal: true

module Journals
  class ParserService < Journals::BaseService
    FIELD_MAP = {
      :date => 0,
      :no_evidence => 1,
      :description => 2,
      :code => 3,
      :name => 4,
      :company_name => 5,
      :debit => 6,
      :credit => 7
    }
    
    def action
      @saved_transaction = []
      sheet.each_with_index do |row, i|        
        next if i < 2

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

      @general_transaction = GeneralTransaction.new(
        number_evidence: @row.no_evidence,
        date: @row.date.to_date,
        company_id: @company_id
      )
    end

    def parse_and_save
      @general_transaction.general_transaction_lines.new(
        code: @row.code,
        debit_idr: @row.debit.to_money,
        credit_idr: @row.credit.to_money,
        description: @row.description,
        company_id: @company_id
      )

      @general_transaction.save!
    end
  end
end
