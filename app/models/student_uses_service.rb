class StudentUsesService < ActiveRecord::Base
  attr_accessible :service_id, :user_id
  
  belongs_to :service
  belongs_to :user
end
