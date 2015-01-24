class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  
  def view_lesson
    @user = User.find(session[:user_id])
    if @user.role == "Teacher"
      @teacher = true
    else
      @teacher = false
    end
    ### This is where I will grab the token and session id
    @current_time = Time.now
    @lesson = Lesson.find(params[:lesson_id])
    @timeslot = @lesson.time_slot
  end
  def index
  
      @user = User.find(session[:user_id])
    if @user.blank?
      redirect_to '/login'
    else
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end
  end
  
  def home
    if params[:uid].blank? && session[:user_id].blank?
      redirect_to "/login"
    elsif !params[:uid].blank?
      uid = params[:uid]
    else
      uid = session[:user_id]
    end
   
    user = User.find(uid)
    session[:user_id] = uid
    if user.role == "Teacher"
      @teacher = true
    else
      @teacher = false
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
