Rails.application.routes.draw do
  get 'static_pages/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: "static_pages#home"


  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  get '/index_user', to: 'users#index'

  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

end
