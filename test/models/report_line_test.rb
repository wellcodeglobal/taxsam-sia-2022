# == Schema Information
#
# Table name: report_lines
#
#  id         :uuid             not null, primary key
#  name       :string
#  order      :integer
#  codes      :string           default([]), is an Array
#  formula    :string
#  group      :string
#  report_id  :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ReportLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
