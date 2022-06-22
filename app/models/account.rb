# == Schema Information
#
# Table name: accounts
#
#  id         :uuid             not null, primary key
#  code       :string
#  name       :string
#  group      :string
#  company_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  belongs_to :company
  include PgSearch::Model

  pg_search_scope :search,
                  against: %i[code name],
                  using: {
                    tsearch: { prefix: true, any_word: true, negation: true }
                  }

end
