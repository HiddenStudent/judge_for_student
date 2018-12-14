module UsersHelper

end

=begin
  root to: 'static_pages#home'

  get '/index_user', to: 'users#index'

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  resources :activation, only: [:edit]
  resources :teacher_admin_controller
  resources :answ
  resources :tasks
  resources :users
  resources :groups

  post 'user_signup', to: 'users#create'

  devise_for :users, controllers: {sessions: 'users/sessions'}

  get 'administration', to: 'teacher_admin#index'

  get 'administration_download_user/:id' => 'teacher_admin#download_user', :via => :get, :as => :administration_download_user
  get 'administration_download_users/:id' => 'teacher_admin#download_all', :via => :get, :as => :administration_download_users

  match 'answ_report/:test' => 'answ#show_report', :via => :get, :as => :answ_report
  match 'answ_create/' => 'answ#create_answ', :via => :post, :as => :answ_create

  match 'users_complete/:id/:text/:ans_id' => 'users#edit_complete' , :via => :get, :as => :users_complete
  match 'users_rework/:id/:text/:ans_id' => 'users#edit_rework' , :via => :get, :as => :users_rework

  match 'users_feedback/:id' => 'users#edit_feedback' , :via => :post, :as => :users_feedback

  match 'user_update_task/:id/:task_id' => 'users#update_task_id', :via => :put, :as => :user_update_task

  match 'check_answ/:id' => 'teacher_admin#check_answ', :via => :get, :as => :check_answ

  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

=end