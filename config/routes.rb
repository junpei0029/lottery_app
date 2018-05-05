Rails.application.routes.draw do
  root 'lottery#index'
  resources :lottery, only: [:index, :new, :create, :show, :destroy] do
    member do
      get 'exec'
    end
    resources :participant, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
