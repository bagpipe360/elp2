class TeachersController < ApplicationController

  before_filter :set_user
  
  def set_user
    @user = User.find(current_identity.user_id)
  end
  
def schedule
  @teacher = @user
  @time_slots = TimeSlot.where(:user_id => @user.id)
  @lessons = Lesson.where(:teacher_id => @user.id)
end
  
  def services
    @user = User.find(current_identity.user_id)
    @services = @user.teacher_teaches_services
    @languages = Language.all
    @levels = Level.all
    @types_of_classes = TypesOfClass.all
  end
  
#  def render_services
#      @user = User.find(current_identity.user_id)
#    @services = @user.teacher_teaches_services
#    @languages = Language.all
#    @levels = Level.all
#    @types_of_classes = TypesOfClass.all
#    render :partial => "render_services"
#  end
  
  
  def subscribe_to_service
    language = Language.find(params[:language_id])
    types_of_class = TypesOfClass.find(params[:service_ids])
    levels = Level.find(params[:level_ids])
    service = Service.where(:types_of_class_id => params[:service_ids], :level_id => params[:level_ids], :language_id => params[:language_id])
    if service.blank?
      service = Service.new(:types_of_class_id => params[:service_ids], :level_id => params[:level_ids], :language_id => params[:language_id])
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
      @user = User.find(current_identity.user_id)
      @teacher = true
    ### This is where I will grab the token and session id
    @current_time = Time.now
    @lesson = Lesson.find(params[:lesson_id])
    @student = @lesson.student
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
      if lesson.student_ready and status == 'true' and lesson.student.online
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
  
  def load_teachers_schedule
  # return  array of events of type { start: ISO, end: ISO, title: string, id: Entity id }
    start_date = params[:start]
    end_date = params[:end]
    start_date = Date.strptime(start_date, '%Y-%m-%d')
    end_date = Date.strptime(end_date, '%Y-%m-%d') - 1.days
    teacher = User.find(current_identity.user_id)
    time_slots = teacher.time_slots
    lessons = teacher.teaching_lessons.where(:start_time => start_date..end_date)
    events = []
    time_slots.each do |ts|
      ts_events = ts.weekly_event_json(start_date.to_datetime, end_date.to_datetime)
      events = events + ts_events
    end
    lessons.each do |lesson|
      lesson_events = lesson.weekly_event_json('teacher')
      events = events + lesson_events
    end
    
    render :json => events
  end
  
end