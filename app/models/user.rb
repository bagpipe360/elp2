class User < ActiveRecord::Base
  attr_accessible :created_at, :description, :first_name, :last_name, :profile_picture, :role, :verified_terms_and_service
  
  
  has_many :favorite_teachers, :foreign_key => "student_id", :class_name => "FavoriteTeacher"
  has_many :students_who_have_favored, :foreign_key => "teacher_id", :class_name => "FavoriteTeacher"
  has_many :taking_lessons, :foreign_key => "student_id", :class_name => "Lesson"
  has_many :teaching_lessons, :foreign_key => "teacher_id", :class_name => "Lesson"
  
  has_many :time_slots
  has_many :lessons, through: :time_slots
  has_many :student_uses_services
  has_many :teacher_teaches_services
#  has_many :levels, through: :teacher_teaches_services
  has_many :services, through: :teacher_teaches_services
  	has_many :levels, through: :services
  has_one :application
  


  
 # Image Upload and processing
  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  
  has_one :identity
  has_one :contract
  
# def favorite_teachers
#       self.select("DISTINCT users.*").joins(:services).where(query)
#  User.joins(:favorite_teachers).where(:id =>  self.id)
# end
  
  def teaching_level(level) 
    services = self.services
      if !services.blank?
        services.each do |s|
          if s.level_id = level
            return true
          end
       end 
      end   
   return false     
  end
  
  def self.teachers
    where(:role => 'Teacher')
  end
  
  def self.students
    where(:role => 'Student')
  end
  
  def name
    self.first_name + ' ' + self.last_name
  end
  
    
  def self.filter_selections(selections)
      skill_level = selections[:skill_level]
      language = selections[:language]
      class_type = selections[:class_type]
      query = ""
      first = true
      if !skill_level.blank?
        query += " level_id = " + skill_level
        first = false
      end
      if !language.blank?
        if !first
          query += " AND "
        end
        query += " language_id = " + language
        first = false
      end
      if !class_type.blank?
        if !first
          query += " AND "
         end
        query += " types_of_class_id = " + class_type
      end
      self.select("DISTINCT users.*").joins(:services).where(query)
  end
  
  def services
    empty = []
    if self.role == 'Student'
      s = self.student_uses_services
    elsif self.role =='Teacher'
      s = self.teacher_teaches_services
    end
    s.each do |serve|
      empty << serve.service
    end
    empty
     end

  
  
end
