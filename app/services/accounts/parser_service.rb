# frozen_string_literal: true

module Accounts
  class ParserService < Accounts::BaseService
    FIELD_MAP = {
      :code => 2,
      :name => 3,
      :group => 4,
      :balance => 5,      
    }

    def action
      sheet.each.with_index(1) do |row, i|
        next if i < 2 || !is_row_valid?(row)
        parse_and_save(row)
      end
    end

    def is_row_valid? row
      return false if row[FIELD_MAP[:code]].blank?
      return false if row[FIELD_MAP[:name]].blank?
      return false if row[FIELD_MAP[:group]].blank?        
      true
    end

    def parse_and_save row
      code = get_account_code(row)
      name = get_account_name(row)
      group = get_group(row)

      new_account = Account.find_or_initialize_by(
        code: code, 
        company_id: @company_id          
      )
      new_account.name = name
      new_account.group = group
      new_account.save!
    end

    def get_account_code row
      row[FIELD_MAP[:code]].to_i.to_s.strip
    end

    def get_account_name row
      row[FIELD_MAP[:name]].to_s.strip
    end

    def get_group row
      group = row[FIELD_MAP[:group]].to_s.strip
      if group == 'D'
        return 'debit'
      end
      if group == 'K'
        return 'credit'
      end

      group
    end
  end
end
