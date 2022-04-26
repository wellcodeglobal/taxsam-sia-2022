# == Schema Information
#
# Table name: general_transaction_lines
#
#  id                     :uuid             not null, primary key
#  code                   :string
#  debit_idr_cents        :decimal(, )      default(0.0), not null
#  debit_idr_currency     :string           default("IDR"), not null
#  credit_idr_cents       :decimal(, )      default(0.0), not null
#  credit_idr_currency    :string           default("IDR"), not null
#  description            :string
#  general_transaction_id :uuid             not null
#  company_id             :uuid             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class GeneralTransactionLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
