class Level < ActiveRecord::Base
  attr_accessible :description, :level
  
  has_many :services
  
end
