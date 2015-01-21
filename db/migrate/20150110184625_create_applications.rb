class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.binary :video_interview
      t.integer :interview_id
      t.binary :resume_upload
      t.string :education
      t.integer :admin_id
      t.string :status
      t.date :date_applied

      t.timestamps
    end
  end
end
