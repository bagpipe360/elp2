class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :application_id
      t.date :date_completed
      t.integer :interview_score

      t.timestamps
    end
  end
end
