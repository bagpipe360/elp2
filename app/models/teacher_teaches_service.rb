class TeacherTeachesService < ActiveRecord::Base
  attr_accessible :service_id, :user_id
  
  belongs_to :service
  belongs_to :user

  
  def language
    
  end
  
  def types_of_class
  end
  
  def level
    
  end
  
 
end
