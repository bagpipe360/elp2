class Application < ActiveRecord::Base
  attr_accessible :admin_id, :date_applied, :education, :interview_id, :resume_upload, :status, :user_id, :video_interview
  
  def self.submitted
    where(:status => 'submitted')
  end
  

end
