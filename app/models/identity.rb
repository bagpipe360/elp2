class Identity < ActiveRecord::Base
  attr_accessible :email, :password_digest, :user_id,:password_confirmation, :remember_me, :password
  
  belongs_to :user
  
    # Include default devise modules. Others available are:
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
  #:confirmable, 
  :lockable, :timeoutable and :omniauthable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
