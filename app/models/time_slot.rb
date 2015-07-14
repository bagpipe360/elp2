class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :user_id, :recurrence_pattern
  
  belongs_to :user
  has_one :lesson
  
  #class constants
  @@current_time = DateTime.now
  @@timeslot_max = 3
  
  validates_datetime :end_time, :after => :start_time, :after_message => "must be at after start time"

#   validate :check_timeslot_length

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
  	newString = "";
  	val.each do |element|
  		newString = newString + element
  	end
  	#newString = newString.gsub(/[^0-9a-z ]/i, '')
    write_attribute(:recurrence_pattern, newString)
  end
  
  def weekly_event_json(start_date, end_date)
  # returns   {id: ts.id, start: ts.start_time.iso8601, end: ts.end_time.iso8601, title: 'Open Slot'} for time slot
    events = []
    recurrence = self.recurrence_pattern
    recurrence.split('').each do |r|
      case r
       when 'M'
        time = end_date.beginning_of_week(:monday)
       when 'T'
        time = end_date.beginning_of_week(:tuesday)
       when 'W'
        time = end_date.beginning_of_week(:wednesday)
       when 'R'
        time = end_date.beginning_of_week(:thursday)
       when 'F'
        time = end_date.beginning_of_week(:friday)
       when 'S'
        time = end_date.beginning_of_week(:saturday)
       when 'N'
        time = end_date.beginning_of_week(:sunday)
       else # the date is a single instance
       time = self.start_time
       end   
      start_time = DateTime.new(time.year, time.month, time.day, self.start_time.hour, self.start_time.min)
      end_time = DateTime.new(time.year, time.month, time.day, self.end_time.hour, self.start_time.min)
      events.push( {:id => self.id, :start => start_time.iso8601, :end => end_time.iso8601, :title => 'title' })
    end
    return events
  end

end
