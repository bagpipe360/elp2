class LessonReview < ActiveRecord::Base
  attr_accessible :comment, :lesson_id, :score
end
