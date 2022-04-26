class CreateJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :journals, id: :uuid do |t|
      t.date :date
      t.string :code
      t.string :description
      t.monetize :debit_idr
      t.monetize :credit_idr
      t.references :journalable, polymorphic: true, null: false, type: :uuid

      t.timestamps
    end
  end
end
