class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_identity!
  ##This locks the whole app will add to specific pages
  before_filter :update_lesson_statuses
  
  @@list_of_states = [ 'scheduled', 'missed', 'recently_taken', 'archived', 'cancelled']
  
  
  
  def update_lesson_statuses
  	@@list_of_states.each_with_index do |state, index|
  		lessons_with_state = Lesson.get_by_status(state)
  		lessons_with_state.each do |lesson|
  			class_time_state = lesson.class_time_state
  			if class_time_state != state
  				lesson.status = class_time_state
  				lesson.save
  			end
  		end
  	end
  end
  
  
end
