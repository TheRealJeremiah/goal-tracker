Rails.application.routes.draw do
  resources :users do
    resources :user_comments, only: [:create]
  end

  resource :session

  resources :goals, except: [:index] do
    resources :goal_comments, only: [:create]
  end

end
