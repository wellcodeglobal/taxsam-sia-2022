class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports, id: :uuid do |t|
      t.string :name
      t.integer :order      
      t.boolean :shown
      t.references :company, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
