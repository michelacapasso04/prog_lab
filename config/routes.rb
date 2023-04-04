Rails.application.routes.draw do
  
  root 'pages#home'

  resource :user, except: [:new]
  resolve('User') { [:user] }
  get '/users/all', to: 'users#index_users'
  get '/user/friends', to: 'users#index_friends'
  delete '/user/friends', to: 'users#remove_friend'
  post '/users/all', to: 'users#add_friend'

  #resources :sessions, only: [:create, :destroy]

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get '/sessions/user', to: 'devise/sessions#create', via: :post
  end

  get '/sessions/user', to: 'devise/sessions#create', via: :post
  

  #get 'signup', to: 'users#new', as: 'signup'
  #get 'login', to: 'pages#login', as: 'login'
  #get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :categories

  get '/categories/users/fav_categories', to:'categories#fav_categories', as: 'fav_categories'
  post '/categories/users/fav_categories', to:'categories#create_fav_categories', as: 'create_fav_categories'

  resources :locations
  
  get '/locations/add_favloc/:id', to: 'locations#addto_favloc', as: 'add_favloc'
  get '/users/locations', to: 'locations#index_favloc', as: 'index_favloc'
  delete '/locations/delete_favloc/:id', to: 'locations#deletefrom_favloc', as: 'delete_favloc'

  
  resources :gatherings

  #generazione e modifica della location
  post '/gatherings/new/generate_locations', to: 'gatherings#generate_locations'
  post '/gatherings/edit/update_location', to: 'gatherings#update_location'


  get '/accept', to: 'locations#accept'
  post '/accept', to: 'locations#accept_locations'

  get '/index_admin', to: 'locations#index_admin'

  


end


