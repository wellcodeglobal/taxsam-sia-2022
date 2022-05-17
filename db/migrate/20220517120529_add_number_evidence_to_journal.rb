class AddNumberEvidenceToJournal < ActiveRecord::Migration[6.1]
  def change
    add_column :journals, :number_evidence, :string
  end
end
