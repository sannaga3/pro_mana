class RenamebmiColumnToBmis < ActiveRecord::Migration[5.2]
  def change
    rename_column :bmis, :bmi, :bmi
  end
end