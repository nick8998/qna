Rails.application.routes.draw do
  use_doorkeeper
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

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show destroy update create] do
        resources :answers, only: %i[show destroy update create], shallow: true
      end
    end
  end

  mount ActionCable.server => '/cable'
end
