class TypesOfClass < ActiveRecord::Base
  attr_accessible :description, :type
  
  has_many :service
end
