class RememberedIp < ActiveRecord::Base
  attr_accessible :blocked, :date_accessed, :ip_address
end
