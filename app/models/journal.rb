class Journal < ApplicationRecord
  belongs_to :journalable, polymorphic: true

  monetize :debit_idr_cents, with_currency: :idr
  monetize :credit_idr_cents, with_currency: :idr
end
