class LessonReviewsController < ApplicationsController

  def index
    @lesson_review = Lesson.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lesson_reviews }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson_review = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson_review }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def review_lesson
    @lid = params[:lid]
    @lesson_review = LessonReview.new

    respond_to do |format|
      format.html # review_lesson.html.erb
      format.json { render json: @lesson_review }
    end
  end

  # GET /lessons/1/edit
  def edit
    @lesson_review = Lesson.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson_review = LessonReview.new(params[:lesson_review])

    respond_to do |format|
      if @lesson_review.save
        format.html { redirect_to '/home', notice: 'Lesson Review was successfully Submitted.' }
        format.json { render json: @lesson_review, status: :created, location: @lesson }
      else
        format.html { render action: "review_lesson" }
        format.json { render json: @lesson_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @lesson_review = Lesson.find(params[:id])

    respond_to do |format|
      if @lesson_review.update_attributes(params[:lesson])
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson_review = Lesson.find(params[:id])
    @lesson_review.destroy

    respond_to do |format|
      format.html { redirect_to lesson_reviews_url }
      format.json { head :no_content }
    end
  end
 

end
