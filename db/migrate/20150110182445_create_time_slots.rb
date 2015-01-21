class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :teacher_id
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
