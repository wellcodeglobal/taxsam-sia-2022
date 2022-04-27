class AddCompanyToJournal < ActiveRecord::Migration[6.1]
  def change
    add_reference :journals, :company, index: true, foreign_key: true, type: :uuid
  end
end
