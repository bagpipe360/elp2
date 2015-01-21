class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.integer :time_slot_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :rounded_time
      t.boolean :student_paid
      t.boolean :teacher_paid
      t.string :token
      t.string :session_id

      t.timestamps
    end
  end
end
