class FavoriteTeacher < ActiveRecord::Migration
  def change
    create_table :favorite_teachers do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.string :comment
      t.timestamps
    end
end
end