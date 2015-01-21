class CreateInterviewQuestions < ActiveRecord::Migration
  def change
    create_table :interview_questions do |t|
      t.integer :question_id
      t.string :question

      t.timestamps
    end
  end
end
