Rails.application.routes.draw do





  resources :email_notify, only: [:edit]        #email

 # match 'activation_user/:id'=> 'activation#edit', :via => :get, :as => :activation_user

  resources :activation, only: [:edit]

  get 'new_users', to: 'users#new'

  post 'user_signup', to: 'users#create'

  get 'atasks/new'

  get 'atasks/edit'

  get 'static_pages/index'

  devise_for :users, controllers: {sessions: 'users/sessions'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#  get 'users/new_registration', to: 'registrations#new'

  root to: 'static_pages#home'


  get 'administration', to: 'teacher_admin#index'

  get 'administration_new', to: 'teacher_admin#new'

  post 'administration_create_task', to: 'teacher_admin#create_task'

  get 'administration_download_user/:id' => 'teacher_admin#download_user', :via => :get, :as => :administration_download_user

  get 'administration_download_users/:id' => 'teacher_admin#download_all', :via => :get, :as => :administration_download_users


  get 'administration_tasks', to: 'teacher_admin#tasks'

  match 'users_complete/:id/:text' => 'users#edit_complete' , :via => :get, :as => :users_complete
  match 'users_rework/:id/:text' => 'users#edit_rework' , :via => :get, :as => :users_rework

  match 'users_feedback/:id' => 'users#edit_feedback' , :via => :post, :as => :users_feedback

  match 'user_update_task/:id/:task_id' => 'users#update_task_id', :via => :put, :as => :user_update_task

  match 'user_progress/:task_id' => 'teacher_admin#tasks_progress', :via => :get, :as => :user_progress

  match 'check_answ/:id' => 'teacher_admin#check_answ', :via => :get, :as => :check_answ

  get 'atasks_show', to: 'atasks#show'

  resources :teacher_admin_controller
  resources :answ
  resources :atasks
  resources :users
  post 'answ_create', to: 'answ#create_answ'

  get 'tasks_progress', to: 'teacher_admin#tasks_progress'

  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  get '/index_user', to: 'users#index'

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

end
