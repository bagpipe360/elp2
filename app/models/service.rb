class Service < ActiveRecord::Base
  attr_accessible :language_id, :level_id, :types_of_class_id
  
  belongs_to :types_of_class
  belongs_to :language
  belongs_to :level
  
  has_many :lessons
  has_many :teacher_teaches_service
  has_many :student_learns_service
  
  def level_name
    self.level.level    
  end
  
  def type_name
    self.types_of_class.type_of_class
  end
  
  def language_name
    self.language.language
  end
  
end
