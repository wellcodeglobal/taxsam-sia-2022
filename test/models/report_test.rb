# == Schema Information
#
# Table name: reports
#
#  id         :uuid             not null, primary key
#  name       :string
#  order      :integer
#  shown      :boolean
#  company_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
