# frozen_string_literal: true

module GeneralTransactionLines
  module SetupJournal
    extend ActiveSupport::Concern
    included do
      after_create :create_journal
    end

    def create_journal
      journal = self.journals.new(
        date: self.general_transaction.date, 
        number_evidence: self.general_transaction.number_evidence,
        code: self.code, 
        description: self.description, 
        company_id: self.company_id        
      )
      journal.debit_idr = self.debit_idr.to_i
      journal.credit_idr = self.credit_idr.to_i
    end
  end
end
