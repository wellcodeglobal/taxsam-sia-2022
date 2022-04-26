# == Schema Information
#
# Table name: general_transactions
#
#  id              :uuid             not null, primary key
#  number_evidence :string
#  date            :date
#  company_id      :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class GeneralTransaction < ApplicationRecord
  belongs_to :company
  has_many :general_transaction_lines, dependent: :destroy
end
