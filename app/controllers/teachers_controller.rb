class TeachersController < ApplicationController

  before_filter :set_user
  
  def set_user
    @user = User.find(session[:user_id])
  end
  
def schedule
  @teacher = @user
  @time_slots = TimeSlot.where(:user_id => @uid)
  @lessons = Lesson.where(:teacher_id => @uid)
end
  
  def services
    @user = User.find(session[:user_id])
    @services = @user.teacher_teaches_services
    @languages = Language.all
    @levels = Level.all
    @types_of_classes = TypesOfClass.all
  end
  
  
  def subscribe_to_service
    language = Language.find(params[:language_id])
    type_of_class = TypesOfClass.find(params[:service_id])
    level = Level.find(params[:level_id])
    service = Service.where(:types_of_class_id => type_of_class, :level_id => level, :language_id => language)
    if service.blank?
      service = Service.new(:types_of_class_id => type_of_class.id, :level_id => level.id, :language_id => language.id)
      if service.save
        t = TeacherTeachesService.new
        t.service_id = service.id
        t.user_id = @user.id
        if t.save
          render :text => 'Success'
        else
          render :text => 'Failure'
        end  
       else
        render :text  => 'Failure'
      end
    else
      service = service.first
      t = TeacherTeachesService.where(:user_id => @user.id, :service_id => service.id)
      if t.blank?
        t = TeacherTeachesService.new
        t.service_id = service.id
        t.user_id = @user.id
        if t.save
          render :text => 'Success'
        else
          render :text => 'Failure'
        end
      else
        render :text => 'Already offering Service'
      end
    end
  end

  
  def unsubscribe_from_service
    service_id = params[:service_id]
    
    
  end
  
end