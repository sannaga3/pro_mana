class CreateBmis < ActiveRecord::Migration[5.2]
  def change
    create_table :bmis do |t|
      t.float :status
      t.date :record_on
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
