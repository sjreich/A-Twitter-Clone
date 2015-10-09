Rails.application.routes.draw do

  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'help' => 'static_pages#help'
  
  get 'signup' => 'users#new'
  resources :users do 
    member do 
      get :listeners
      get :loudspeakers
    end
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'login' => 'sessions#destroy'

  resources :messages

  resources :relationships, only: [:create, :destroy]
end
