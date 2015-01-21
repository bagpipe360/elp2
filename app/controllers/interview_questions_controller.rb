class InterviewQuestionsController < ApplicationController
  # GET /interview_questions
  # GET /interview_questions.json
  def index
    @interview_questions = InterviewQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interview_questions }
    end
  end

  # GET /interview_questions/1
  # GET /interview_questions/1.json
  def show
    @interview_question = InterviewQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interview_question }
    end
  end

  # GET /interview_questions/new
  # GET /interview_questions/new.json
  def new
    @interview_question = InterviewQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interview_question }
    end
  end

  # GET /interview_questions/1/edit
  def edit
    @interview_question = InterviewQuestion.find(params[:id])
  end

  # POST /interview_questions
  # POST /interview_questions.json
  def create
    @interview_question = InterviewQuestion.new(params[:interview_question])

    respond_to do |format|
      if @interview_question.save
        format.html { redirect_to @interview_question, notice: 'Interview question was successfully created.' }
        format.json { render json: @interview_question, status: :created, location: @interview_question }
      else
        format.html { render action: "new" }
        format.json { render json: @interview_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /interview_questions/1
  # PUT /interview_questions/1.json
  def update
    @interview_question = InterviewQuestion.find(params[:id])

    respond_to do |format|
      if @interview_question.update_attributes(params[:interview_question])
        format.html { redirect_to @interview_question, notice: 'Interview question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interview_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interview_questions/1
  # DELETE /interview_questions/1.json
  def destroy
    @interview_question = InterviewQuestion.find(params[:id])
    @interview_question.destroy

    respond_to do |format|
      format.html { redirect_to interview_questions_url }
      format.json { head :no_content }
    end
  end
end
