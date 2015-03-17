Rails.application.routes.draw do
  resources :users do
    resources :comments, only: [:create]
  end

  resource :session

  resources :goals, except: [:index] do
    resources :comments, only: [:create]
  end
end
