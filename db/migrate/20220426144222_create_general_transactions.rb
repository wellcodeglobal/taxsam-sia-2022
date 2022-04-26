class CreateGeneralTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :general_transactions, id: :uuid do |t|
      t.string :number_evidence
      t.date :date
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
