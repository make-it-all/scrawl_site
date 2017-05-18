Rails.application.routes.draw do

  get 'pages/help'

  # CLEAREANCE
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  #API

  namespace :api do
    namespace :v1 do
      namespace :auth do
        #Sign in and out
        post '/sign_in' => 'sessions#create'
        delete '/sign_out' => 'sessions#destroy'
        post '/sign_up' => 'users#create'
      end
      match :ping, controller: 'api_base', via: [:GET, :POST, :PUT, :PATCH, :DELETE, :HEAD]
      resources :notes do
        collection do
          post :sync
        end
      end
    end
  end


  resources :notes
  root 'notes#index'
  get 'help', to: 'pages#help'

end
