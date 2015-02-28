class TempController < ApplicationController
	before_filter :set_user
	
	def set_user
		identity = Identity.find(current_identity.id)
		@user = identity.user
		if @user.role == 'student'
			@lessons = @user.lessons_taken
			@teacher = false
		elsif @user.role == 'teacher'
			@teacher = true
			@lessons = @user.lessons_taught
		end
	
	end
	
	
	def lesson
		@lesson = Lesson.first
		if @teacher
			@subscriberName = 'Student'
			@publisherName = 'Teacher'
		else
			@subscriberName = 'Teacher'
			@publisherName = 'Student'
		end

	end
	
	
	def createKeys
		keysHash = {}
		config_opentok
		#temporary settings to develop video chatting
		@lesson = Lesson.first
		session = @opentok.create_session(['p2p.preference','enabled'])
		@lesson.session_id = session.session_id
#		teacher = User.find(session[:user_id])

		token = session.generate_token
		@lesson.token = token
		@lesson.save
		
		
		keysHash[:sessionID] = session.session_id
		keysHash[:token] = token
		
		render :json => keysHash.to_json
	end
	

	def studentAccept
		keysHash = {}
		#temporary settings to develop video chatting
		@lesson = Lesson.first
		token = @lesson.token
		@lesson.save
		
		
		keysHash[:sessionID] = @lesson.session_id
		keysHash[:token] = token
		
		render :json => keysHash.to_json	
	end

	def destroy
	
	
	end


	private
	
	def config_opentok
		if @opentok.nil?
			@opentok = OpenTok::OpenTok.new '45159872', '82a9cdc2ecd85984db36be7975afee1fded7143c'

		end
	end

end
