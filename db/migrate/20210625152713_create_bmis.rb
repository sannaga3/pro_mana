class CreateBmis < ActiveRecord::Migration[5.2]
  def change
    create_table :bmis do |t|
      t.integer :height, null: false
      t.float :weight, null: false
      t.float :bmi
      t.date :record_on, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
