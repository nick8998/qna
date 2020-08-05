Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  resources :questions do

    delete :delete_file, on: :member

    resources :answers, shallow: true, only: %i[create update destroy] do
      patch :update_best, on: :member
      delete :delete_file, on: :member
    end
  end
end
