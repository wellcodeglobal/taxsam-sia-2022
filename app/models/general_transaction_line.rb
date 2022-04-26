class GeneralTransactionLine < ApplicationRecord
  belongs_to :general_transaction
  belongs_to :company
  has_many :journals, as: :journalable, dependent: :destroy
  
  monetize :debit_idr_cents, with_currency: :idr
  monetize :credit_idr_cents, with_currency: :idr
end
