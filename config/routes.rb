Rails.application.routes.draw do
  root to: 'movies#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  namespace :admin do
    resources :schedules, only: [:index, :show, :create, :update, :destroy]
    resources :screens, except: :show
    resources :reservations
    resources :movies do
      resources :schedules, only: [:new, :edit]
    end
  end

  resources :movies, only: [:index, :show] do
    get :reservation, on: :member
  end

  resources :sheets, only: [:index]

  resources :reservations, only: [:create]
  get '/movies/:movie_id/schedules/:schedule_id/reservations/new', to: 'reservations#new', as: 'new_reservation'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
