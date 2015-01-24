class StudentsController < ApplicationController

  
  def favorite_teachers
    @user = User.find(session[:user_id])
    @favorite_teachers = @user.favorite_teachers
  end

  def lessons
    @user = User.find(session[:user_id])
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
    @user = User.find(session[:user_id])

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
  
  
end