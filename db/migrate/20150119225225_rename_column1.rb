class RenameColumn1 < ActiveRecord::Migration
  def change
    rename_column :time_slots, :teacher_id, :user_id
  end
end
