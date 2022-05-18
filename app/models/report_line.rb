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
class ReportLine < ApplicationRecord
  belongs_to :report
  default_scope { order(order: :asc) }

  enum group: {
    category: "category",
    component: "component",
    accumulation: "accumulation"
  }
end
