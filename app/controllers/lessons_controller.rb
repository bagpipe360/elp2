class LessonsController < ApplicationsController

  def index
    @lessons = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    @lesson = Lesson.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/1/edit
  def edit
    @lesson = Lesson.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(params[:lesson])

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render json: @lesson, status: :created, location: @lesson }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      if @lesson.update_attributes(params[:lesson])
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end
  
  def begin_lesson
    start_time = params[:start_time].to_datetime
    lesson = Lesson.find(params[:lesson_id])
    lesson.start_time = start_time
    if lesson.save
      msg = "Success"
    else
      msg = "Failure"
    end
    render :text => msg
   end
  
  def end_lesson
    end_time = params[:end_time].to_datetime
    lesson = Lesson.find(params[:lesson_id])
    lesson.end_time = end_time
    rounded_time = ((end_time.to_f - lesson.start_time.to_f) / 60.0).to_f
    lesson.rounded_time = rounded_time
    puts lesson.rounded_time
    puts lesson.end_time
    puts lesson.start_time
    puts "check here"
    if lesson.save
      msg = lesson.rounded_time.to_s
    else
      msg = "Failure"
    end
    render :text => msg
   end
  
  def get_video_keys
    puts 'get video keys'
		keysHash = {}
		config_opentok
    puts params
    @lesson = Lesson.find(params[:lid])
    if @lesson.session_id.blank?
      session = @opentok.create_session(['p2p.preference','enabled'])
      @lesson.session_id = session.session_id
	  	@lesson.token = session.generate_token
      @lesson.save
    else
      session_id = @lesson.session_id
      token = @lesson.token
      puts "check token info"
      puts token
    end
				
    keysHash[:sessionID] = @lesson.session_id
    keysHash[:token] = @lesson.token
    render :json => keysHash.to_json
  end
  
  
	def studentAccept
		keysHash = {}
		#temporary settings to develop video chatting
    @lesson = Lesson.find(params[:lid])
		keysHash[:sessionID] = @lesson.session_id
    keysHash[:token] = @lesson.token
		
		render :json => keysHash.to_json	
	end
  
  def new_message
    @lesson_id = params[:lid]
    @other_user_id = params[:uid]
    @channel = "/lesson/private/" + @lesson_id.to_s + "/" + @other_user_id.to_s
    puts 'Check channel' + @channel
    @message = {:msg => params[:message]}
    respond_to do |f|
      f.js
    end
  end
  
  
 def update_lesson_status
    puts params
   @user = User.find(current_identity.user_id)
    @lesson_id = params[:lid]
    lesson = Lesson.find(@lesson_id)
    status = params[:ready]
   @channel = "/other_user_updates/" + @lesson_id.to_s + "/" + @user.id.to_s
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
      puts @message
      respond_to do |f|
        f.js
      end
    end
  end
    
  def lesson
     user = User.find(current_identity.user_id)
#      @teacher = false
    ### This is where I will grab the token and session id
    @current_time = Time.now
    lesson = Lesson.find(params[:lesson_id])
    @lesson_id = lesson.id
    @user_id = user.id
    @pretty_time_till = lesson.pretty_time_till
    if lesson.teacher_ready
      @teacherStatus = 'Ready'
    else
      @teacherStatus = 'Not Ready'
    end
    if lesson.student_ready
      @studentStatus = 'Ready'
    else
      @studentStatus = 'Not Ready'
    end
    if lesson.teacher_ready and lesson.student_ready
      @ready_to_start = true
    else
      @ready_to_start = false
    end
    if user == lesson.teacher
      @otherUser = lesson.student
      @userStatus = @teacherStatus
      @otherUserStatus = @studentStatus
      @typeOfUser = 'Teacher'
    else
      @otherUser = lesson.teacher
      @userStatus = @studentStatus
      @otherUserStatus = @teacherStatus
      @typeOfUser = 'Student'
    end
    #@teacher_user = @lesson.teacher
    #@teacher_paid = @lesson.teacher_paid
    #@student_paid =  @lesson.student_paid
    timeslot = lesson.time_slot 
    @start_time = timeslot.pretty_start
    @end_time =timeslot.pretty_end
    case lesson.class_time_state
    when 'missed'
      @missed_class = true
      @message = "This class was missed."
    when 'taken'
      @taken_class = true
      @message = "This class was taken"
    when 'scheduled'
      @scheduled_class = true
      @message = "This class is currently scheduled"
    when 'cancelled'
      @cancelled_class = true
      @message = "This class was cancelled"
    end
      #There are different rules on whether a teacher or student can cancel a class
    @show_cancel_lesson = lesson.allow_lesson_cancel
  end
  
    def class_time_state
    #A class can be missed, taken, scheduled, rescheduled, or cancelled.
    if self.missed
      'missed'
    elsif self.taken
      'taken'
    elsif self.scheduled
      'scheduled'
    #elsif self.rescheduled
      #'rescheduled
    elsif self.cancelled
      'cancelled'
    end
  end
  
  
  def cancel_class_teacher
    lesson = Lesson.find(params[:lid])
    lesson.cancel('teacher')
    lesson.save
    flash[:notice] = "Lesson successfully cancelled."
    redirect_to '/teacher/schedule'
  end
  
  def cancel_class_student
    lesson = Lesson.find(params[:lid])
    lesson.cancel('student')
    lesson.save
    flash[:notice] = "Lesson successfully cancelled."
  #  redirect_to '/teacher/schedule'
  end
  
  def end_lesson
    #need time class was taken and cost
    lesson = Lesson.find(params[:lesson])
    lesson.end
    #return time class was taken
  end
    
    def lesson_cost
      lesson = Lesson.find(params[:lesson])
      lesson.calculate_cost
    end
    
    def report_problem
      lesson = Lesson.find(params[:lesson])
      lesson.report_problem(params[:problem])
    end
      
      
  private

	def config_opentok
		if @opentok.nil? 
			@opentok = OpenTok::OpenTok.new '45188672', '63b02dc234a56ada8d0aeeed1f90fb8930efaffd'

		end
	end

end
