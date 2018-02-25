Rails.application.routes.draw do
  root to: 'gmaps#index'
  devise_for :members


  get 'members/search'
  post 'gmaps/destroy_images'
  get 'members/touroku'

#  resources :sessions, only: %i[new create destroy]
  resources :members
  resources :gmaps, only: %i[index new show create edit update destroy] do
    collection do
      get :confirm
      post :check
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
