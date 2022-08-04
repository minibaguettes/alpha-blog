Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to:'pages#about'

  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  # since all resources are exposed in the above, can simply use below code
  resources :articles 
  # exposed all REST-ful routes for article resources
  # REST = representational state transfer - mapping HTTP verbs (get, post, put/patch, delete) to CRUD actions; front end mapped to back end
  
  get 'signup', to: 'users#new'
  #post 'users', to: 'users#create'
  resources :users, except: [:new]
  # get all route / users, except for new route for users
  
  get 'login', to: 'sessions#new' # sessions controller to manage logging in and out
  post 'login', to: 'sessions#create'  # handles form submission
  get 'logout', to: 'sessions#destroy'
end
