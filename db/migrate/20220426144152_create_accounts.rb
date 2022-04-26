class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :code
      t.string :name
      t.string :group
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
