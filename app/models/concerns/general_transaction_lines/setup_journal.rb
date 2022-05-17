# frozen_string_literal: true

module GeneralTransactionLines
  module SetupJournal
    extend ActiveSupport::Concern
    included do
      after_create :create_journal
    end

    def create_journal
      self.journals.create(
        date: self.general_transaction.date, 
        number_evidence: self.general_transaction.number_evidence,
        code: self.code, 
        description: self.description, 
        debit_idr_cents: self.debit_idr, 
        credit_idr_cents: self.credit_idr, 
        company_id: self.company_id        
      )
    end
  end
end
