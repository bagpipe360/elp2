class CreateTeacherTeachesServices < ActiveRecord::Migration
  def change
    create_table :teacher_teaches_services do |t|
      t.integer :service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
