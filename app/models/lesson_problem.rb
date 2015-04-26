class LessonProblem < ActiveRecord::Base
  attr_accessible :lesson_id, :problem
  
  belongs_to :lesson
end

