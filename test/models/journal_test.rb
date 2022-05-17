# == Schema Information
#
# Table name: journals
#
#  id                  :uuid             not null, primary key
#  date                :date
#  code                :string
#  description         :string
#  debit_idr_cents     :decimal(, )      default(0.0), not null
#  debit_idr_currency  :string           default("IDR"), not null
#  credit_idr_cents    :decimal(, )      default(0.0), not null
#  credit_idr_currency :string           default("IDR"), not null
#  journalable_type    :string           not null
#  journalable_id      :uuid             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :uuid
#  number_evidence     :string
#
require "test_helper"

class JournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
