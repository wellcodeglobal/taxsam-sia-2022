# == Schema Information
#
# Table name: accounts
#
#  id                   :uuid             not null, primary key
#  code                 :string
#  name                 :string
#  account_type         :string
#  company_id           :uuid             not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subclassification    :string
#  subclassification_en :string
#  balance_type         :string
#
require "test_helper"

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
