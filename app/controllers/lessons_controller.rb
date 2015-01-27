class LessonsController < ApplicationController
  # GET /lessons
  # GET /lessons.json
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
  


end
