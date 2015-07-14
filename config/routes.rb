Elp2::Application.routes.draw do
  devise_for :identities

  get "sessions/new"

  get "sessions/create"

  resources :interviews
  resources :interview_questions
  resources :applications
  resources :identities
  resources :lesson_reviews
  resources :lessons
  resources :time_slots
  resources :users
  
  get  '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  
  get '/home', to: 'users#home'
 # get '/login', to: 'identities#login'
  get '/user/view_lesson', to: 'users#view_lesson'
  
  get '/lesson/get_video_keys', to: 'lessons#get_video_keys'
  
  get '/update_online_status', to: 'users#update_online_status'
  
  get '/teacher/schedule', to: 'teachers#schedule'
  get 'load_teachers_schedule', to: 'teachers#load_teachers_schedule'
  get '/teacher/services', to: 'teachers#services'
  get '/teacher/save_service', to: 'teachers#subscribe_to_service'
  get '/teacher/lesson', to: 'teachers#lesson'
  #post '/teacher/new_message' => 'teachers#new_message', :as => :new_message
  post '/teacher/update_lesson_status', to: 'teachers#update_lesson_status'

  get 'student/favorite_teachers', to: 'students#favorite_teachers'
  get 'student/lessons', to: 'students#lessons'
  get 'student/search', to: 'students#search'
  get 'student/view_teacher', to: 'students#view_teacher'
  get 'student/sign_up', to: 'students#sign_up' 
  get 'student/save_lesson', to: 'students#save_lesson'
  get '/student/lesson', to: 'students#lesson'
  get '/student/lesson_ready', to: 'students#lesson_ready'
  #post '/student/new_message' => 'students#new_message', :as => :new_message
  post '/student/update_lesson_status', to: 'students#update_lesson_status'
  get '/student/review_lesson', to: 'lesson_reviews#review_lesson'
  post '/student/add_favorite_teacher', to: 'students#add_favorite_teacher'
  post '/student/remove_favorite_teacher', to: 'students#remove_favorite_teacher'
  get '/student/schedule', to: 'students#schedule'
  get 'load_student_schedule', to: 'students#load_student_schedule'
 
  get '/lesson/lesson', to: 'lessons#lesson'
  get '/lesson/begin_lesson', to: 'lessons#begin_lesson'
  get '/lesson/end_lesson', to: 'lessons#end_lesson'
  post '/lesson/new_message' => 'lessons#new_message', :as => :new_message
  post '/lesson/update_lesson_status', to: 'lessons#update_lesson_status'
  get '/lesson/cancel_class_Teacher', to: 'lessons#cancel_class_teacher'
  get '/lesson/cancel_class_Student', to: 'lessons#cancel_class_student'
  get '/lesson/report_problem', to: 'lessons#report_problem'
  post '/render_filtered_results', to: 'lessons#render_filtered_results'
  

    

    

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
 # root :to => 'identities#login'
  root  :to => 'home#home'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
