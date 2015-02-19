class AddThingsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean, :default => false
    add_column :lessons, :student_ready, :boolean, :default => false
    add_column :lessons, :teacher_ready, :boolean, :default => false
  end
end
