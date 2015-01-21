class CreateLessonReviews < ActiveRecord::Migration
  def change
    create_table :lesson_reviews do |t|
      t.integer :lesson_id
      t.integer :score
      t.string :comment

      t.timestamps
    end
  end
end
