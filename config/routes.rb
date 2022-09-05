Rails.application.routes.draw do
  
  root 'users#index'

  get '/signup' => 'users#new'
  get '/profile' => 'users#profile'
  post '/users' => 'users#create'
	
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :password_resets


end
