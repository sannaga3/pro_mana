class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :protain, null: false
      t.integer :quantity, null: false
      t.string :unit, null: false
      t.timestamps
    end
  end
end
