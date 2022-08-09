class CreateClosedJournals < ActiveRecord::Migration[6.1]
  def change
    create_table :closed_journals, id: :uuid do |t|
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
