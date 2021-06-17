class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.integer :ate, null: false
      t.date :record_on, null: false
      t.references :food, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
