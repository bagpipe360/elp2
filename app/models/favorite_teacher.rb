class FavoriteTeacher < ActiveRecord::Base
  attr_accessible :student_id, :teacher_id, :comment
  
  
  
  belongs_to :teacher, :class_name => "User"
  belongs_to :student, :class_name => "User"

  
#  def teachers
#    teachers = []
#    self.each do |favorite_teacher|
#      teachers.push(favorite_teacher.teacher)
#    end
#    return teachers
#  end
  
  def teacher
    User.find(self.teacher_id)
  end
  
end
