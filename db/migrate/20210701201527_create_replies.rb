class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.text :comment
      t.integer :replyer_id
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
