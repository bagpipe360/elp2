class Language < ActiveRecord::Base
  attr_accessible :language, :location
  
  has_many :service
end
