class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :user_id, :recurrence_pattern
  
  belongs_to :user
  has_one :lesson
  
  #class constants
  @@current_time = DateTime.now
  @@timeslot_max = 3
  
  validates_datetime :start_time, :after => @@current_time, :after_message => "must be at after current time"
  validates_datetime :end_time, :after => @@current_time,  :after_message => "must be at after current time"
  validates_datetime :end_time, :after => :start_time, :after_message => "must be at after start time"

  validate :check_timeslot_length

  def check_timeslot_length
    time_diff = Time.diff(end_time,start_time, '%H')
    errors.add(:end_time, " - start_time can't extend #{@@timeslot_max} hours") if time_diff[:hour] >= @@timeslot_max
  end
  
    def pretty_start      
    self.start_time.strftime("%m/%d/%Y, %I:%M %P")   #=> "Printed on 11/19/2007"
  end
  
  def pretty_end
    self.end_time.strftime("%I:%M %P")   #=> "Printed on 11/19/2007"
  end
  
  
  def recurrence_pattern=(val)
    write_attribute(:recurrence_pattern, val.strip)
  end
  
end
