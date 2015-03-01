class TeachersController < ApplicationController

  before_filter :set_user
  
  def set_user
    @user = User.find(session[:user_id])
  end
  
def schedule
  @teacher = @user
  @time_slots = TimeSlot.where(:user_id => @user.id)
  @lessons = Lesson.where(:teacher_id => @user.id)
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
  
  def lesson
      @user = User.find(session[:user_id])
      @teacher = true
    ### This is where I will grab the token and session id
    @current_time = Time.now
    @lesson = Lesson.find(params[:lesson_id])
    @teacher_paid = @lesson.teacher_paid
    @student_paid =  @lesson.student_paid
    @timeslot = @lesson.time_slot 
    @taken = !@lesson.start_time.blank?
      if @lesson.teacher_ready and @lesson.student_ready
      @ready_to_start = true
    else
      @ready_to_start = false
    end 
  end
  
      # It's PRIVATE, so send it to the PRIVATE channel
 def new_message
    @lesson_id = params[:lid]
    @channel = "/lesson/private/" + @lesson_id
    @message = {:msg => params[:message]}
    respond_to do |f|
      f.js
    end
  end
  
  def update_lesson_status
    puts params
    @lesson_id = params[:lid]
    lesson = Lesson.find(@lesson_id)
    status = params[:ready]
    @channel = "/teacher_updates/" + @lesson_id
    #Check student status to activate StartVideo

    if status == 'true'
      lesson.teacher_ready = true
    else
      lesson.teacher_ready = false
    end
    if lesson.save
      if lesson.student_ready and status == 'true'
        start_lesson = true
      else
        start_lesson = false
      end
      @message = {:status => status, :start_lesson => start_lesson}
      respond_to do |f|
        f.js
      end
    end
  end
  
end