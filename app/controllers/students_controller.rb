class StudentsController < ApplicationController

  
  def favorite_teachers
    @user = User.find(current_identity.user_id)
    @favorite_teachers = @user.favorite_teachers
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
  
  def search
    @teachers = User.teachers  
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
      if lesson.teacher_ready and status == 'true'
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