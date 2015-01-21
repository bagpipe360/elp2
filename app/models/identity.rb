class Identity < ActiveRecord::Base
  attr_accessible :email, :password_digest, :user_id
  
  belongs_to :user
end
