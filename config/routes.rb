Rails.application.routes.draw do
post 'gmaps/destroy_images'
  get 'users/touroku'
  root to: 'gmaps#index'

  resources :sessions, only: %i[new create destroy]
  resources :users do
    get :search, on: :collection
  end
  resources :gmaps, only: %i[index new show create edit update destroy] do
    collection do
      get :confirm
      post :check
    end
  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
