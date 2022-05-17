# == Schema Information
#
# Table name: companies
#
#  id         :uuid             not null, primary key
#  name       :string
#  codename   :string
#  slug       :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :general_transactions, dependent: :destroy
  has_many :general_transaction_lines, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :reports, dependent: :destroy
end
