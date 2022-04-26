class GeneralTransaction < ApplicationRecord
  belongs_to :company
  has_many :general_transaction_lines, dependent: :destroy
end
