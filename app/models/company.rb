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

  validates :name, :codename, presence: true
  validates :slug, presence: true, uniqueness: true
  before_save :set_slug

  def set_slug
    return if slug.present?    
    self.slug = self.name.parameterize
  end
end
