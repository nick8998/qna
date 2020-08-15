Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true, only: %i[create update destroy] do
      patch :update_best, on: :member
    end
  end

  resources :attachments , only: %i[destroy]
  resources :links , only: %i[destroy]

  namespace :user do
    resources :rewards, only: :index
  end

  resources :votes do
    collection do
     put '/vote_up/:id' => "votes#vote_up", :as => :vote_up
     put '/vote_down/:id' => "votes#vote_down", :as => :vote_down
     delete '/vote_cancel/:id' => "votes#vote_cancel", :as => :vote_cancel
    end
  end
end
