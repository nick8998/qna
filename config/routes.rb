Rails.application.routes.draw do
  concern :votable do
    put :vote_up, on: :member
    put :vote_down, on: :member
    delete :vote_cancel, on: :member
  end
  concern :commentable do
    post :create_comment, on: :member
  end

  devise_for :users
  root to: 'questions#index'

  resources :questions, concerns: %i[votable commentable] do
    resources :answers, concerns: %i[votable commentable], shallow: true, only: %i[create update destroy] do
      patch :update_best, on: :member
    end
  end


  resources :attachments , only: %i[destroy]
  resources :links , only: %i[destroy]

  namespace :user do
    resources :rewards, only: :index
  end

  mount ActionCable.server => '/cable'
end
