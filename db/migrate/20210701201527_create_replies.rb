class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.text :comment, null: false
      t.integer :replyer_id, null: false
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
