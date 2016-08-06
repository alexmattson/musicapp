Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  resources :bands do
    member do
      resources :albums, only: [:new] do
        member do
          resources :tracks, only: [:new]
        end
      end
    end
  end

  resources :albums, except: [:new]
  resources :tracks, except: [:new]
  resources :notes, except: [:new, :index, :show]

  root to:'bands#index'

end
