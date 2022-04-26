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
require "test_helper"

class GeneralTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
