class AddColumnForCcounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :subclassification, :string
    add_column :accounts, :subclassification_en, :string
    add_column :accounts, :balance_type, :string
    rename_column :accounts, :group, :account_type
  end
end
