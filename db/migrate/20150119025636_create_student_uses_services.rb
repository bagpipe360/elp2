class CreateStudentUsesServices < ActiveRecord::Migration
  def change
    create_table :student_uses_services do |t|
      t.integer :service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
