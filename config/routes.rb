Elp2::Application.routes.draw do
  resources :interviews


  resources :interview_questions


  resources :applications


  resources :identities


  resources :time_slots


  resources :users
  
  get '/home', to: 'users#home'
  get '/login', to: 'identities#login'
  
  get '/teacher/schedule', to: 'teachers#schedule'
  get '/teacher/services', to: 'teachers#services'
  get '/teacher/save_service', to: 'teachers#subscribe_to_service'
  
  get 'student/favorite_teachers', to: 'students#favorite_teachers'
  get 'student/lessons', to: 'students#lessons'
  get 'student/search', to: 'students#search'
  get 'student/view_teacher', to: 'students#view_teacher'
  get 'student/sign_up', to: 'students#sign_up' 
  get 'student/save_lesson', to: 'students#save_lesson'


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
  root :to => 'identities#login'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
