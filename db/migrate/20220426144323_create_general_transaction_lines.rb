class CreateGeneralTransactionLines < ActiveRecord::Migration[6.1]
  def change
    create_table :general_transaction_lines, id: :uuid do |t|
      t.string :code
      t.monetize :debit_idr
      t.monetize :credit_idr
      t.string :description
      t.references :general_transaction, null: false, foreign_key: true, type: :uuid
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
