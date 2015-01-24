class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :user_id
  
  belongs_to :user
  has_one :lesson
  
  
end
