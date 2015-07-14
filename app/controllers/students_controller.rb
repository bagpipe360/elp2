class StudentsController < ApplicationController
  before_filter :set_user
  
  def set_user
    @user = User.find(current_identity.user_id)
  end
  
  #params: elem_id, elem_type (teacher, class..)
  def add_favorite_teacher
    teacher = User.find(params[:teacher_id])
    ft = FavoriteTeacher.new
    ft.teacher_id = params[:teacher_id]
    ft.student_id = current_identity.user_id
    ft.save
    render_favorite_teachers
    render :partial => "render_favorite_teachers"
  end

  
  def remove_favorite_teacher
    FavoriteTeacher.where(:teacher_id => params[:teacher_id], :student_id => current_identity.user_id).destroy_all
    render_favorite_teachers
    render :partial => "render_favorite_teachers"
  end
  
  def render_favorite_teachers
      @user = User.find(current_identity.user_id)
    @favorite_teachers = []
    favorite_teachers_relations = @user.favorite_teachers
    favorite_teachers_relations.each do |favorite_teacher_relation|
      @favorite_teachers.push(favorite_teacher_relation.teacher)
    end
    @teachers = User.teachers - @favorite_teachers
  end
  
  def favorite_teachers
    @user = User.find(current_identity.user_id)
    @favorite_teachers = []
    favorite_teachers_relations = @user.favorite_teachers
    favorite_teachers_relations.each do |favorite_teacher_relation|
      @favorite_teachers.push(favorite_teacher_relation.teacher)
    end
    @teachers = User.teachers - @favorite_teachers
  end
  
  

  
  def lessons
    @user = User.find(current_identity.user_id)
    @lessons = @user.taking_lessons
	
  end
  
  def view_teacher
    @user = User.find(params[:id])
  end
  
  def sign_up
    @timeslot = TimeSlot.find(params[:ts_id])
    @teacher = User.find(@timeslot.user_id)
  end
  
  def save_lesson
    @user = User.find(current_identity.user_id)

    return_msg = ""
    @service = Service.find(params[:service_id])
    @timeslot = TimeSlot.find(params[:timeslot_id])
    lesson = Lesson.where(:time_slot_id => @timeslot.id, :service_id => @service.id)
    if !lesson.blank?
      return_msg = "Filled"
    else
      lesson = Lesson.new
      lesson.teacher_id = @timeslot.user_id
      lesson.student_id = @user.id
      lesson.service_id = @service.id
      lesson.time_slot_id = @timeslot.id
      if lesson.save
        return_msg = "Success"
      else
        return__msg = "Failed"
      end
    end
    render :text => return_msg
      
  end
  
  def schedule
    @student = @user
    @lessons = Lesson.where(:student_id => @user.id)
  end
  
  def load_student_schedule
  # return  array of events of type { start: ISO, end: ISO, title: string, id: Entity id }
    start_date = params[:start]
    end_date = params[:end]
    start_date = Date.strptime(start_date, '%Y-%m-%d')
    end_date = Date.strptime(end_date, '%Y-%m-%d') - 1.days
    lessons =  @user.taking_lessons.where(:start_time => start_date..end_date)
    events = []
    lessons.each do |lesson|
      lesson_events = lesson.weekly_event_json('student')
      events = events + lesson_events
    end
    render :json => events
  end
  
  def search
    @teachers = User.teachers
    @skill_levels = Level.all
    @languages = Language.all
    @class_types = TypesOfClass.all  
  end
  
  def lesson
     @user = User.find(current_identity.user_id)
      @teacher = false
    ### This is where I will grab the token and session id
    @current_time = Time.now
    @lesson = Lesson.find(params[:lesson_id])
    @teacher_user = @lesson.teacher
    @teacher_paid = @lesson.teacher_paid
    @student_paid =  @lesson.student_paid
    @timeslot = @lesson.time_slot 
    @taken = !@lesson.start_time.blank?
    if @lesson.teacher_ready
      @teacher_status = 'Ready'
    else
      @teacher_status = 'Not Ready'
    end
    if @lesson.teacher_ready and @lesson.student_ready
      @ready_to_start = true
    else
      @ready_to_start = false
    end
  end
  
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
    ## Check Teachers status to enable StartVideo

    @channel = "/student_updates/" + @lesson_id
    if status == 'true'
      lesson.student_ready = true
    else
      lesson.student_ready = false
    end
    if lesson.save
      if lesson.teacher_ready and status == 'true' and lesson.teacher.online
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