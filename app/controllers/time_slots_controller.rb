class TimeSlotsController < ApplicationController
  # GET /time_slots
  # GET /time_slots.json
  def index
    @time_slots = TimeSlot.where(:user_id => current_identity.user_id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_slots }
    end
  end

  # GET /time_slots/1
  # GET /time_slots/1.json
  def show
    @time_slot = TimeSlot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_slot }
    end
  end

  # GET /time_slots/new
  # GET /time_slots/new.json
  def new
    @time_slot = TimeSlot.new
    @recurrence_array = []
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_slot }
    end
  end

  # GET /time_slots/1/edit
  def edit
    @time_slot = TimeSlot.find(params[:id])
    @recurrence_array = @time_slot.recurrence_pattern.split(//) 
  end

  # POST /time_slots
  # POST /time_slots.json
  def create
    @time_slot = TimeSlot.new(params[:time_slot])
    @time_slot.user_id = current_identity.user_id
	@recurrence_array = []
    respond_to do |format|
      if @time_slot.save
        format.html { redirect_to @time_slot, notice: 'Time slot was successfully created.' }
        format.json { render json: @time_slot, status: :created, location: @time_slot }
      else
        format.html { render action: "new" }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_slots/1
  # PUT /time_slots/1.json
  def update
    @time_slot = TimeSlot.find(params[:id])
    @recurrence_array = @time_slot.recurrence_pattern.split(//)
    respond_to do |format|
      if @time_slot.update_attributes(params[:time_slot])
        format.html { redirect_to @time_slot, notice: 'Time slot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_slots/1
  # DELETE /time_slots/1.json
  def destroy
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.destroy

    respond_to do |format|
      format.html { redirect_to time_slots_url }
      format.json { head :no_content }
    end
  end
end
