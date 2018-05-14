Rails.application.routes.draw do
  root to: 'gmaps#index'
  devise_for :members
  get 'members/downloadpdf/download', to: 'members#downloadpdf'

  resources :members, only: [:show] do
    collection do
      get :search
      get :dispatching
    end
  end
  resources :gmaps do
    collection do
      get :confirm
      post :check
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
