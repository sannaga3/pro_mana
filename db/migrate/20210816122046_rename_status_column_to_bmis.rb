class RenameStatusColumnToBmis < ActiveRecord::Migration[5.2]
  def change
    rename_column :bmis, :status, :bmi
  end
end