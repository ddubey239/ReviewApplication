Rails.application.routes.draw do
  resources :movies do
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show] do
        resources :comments, only: [:index, :show]
      end
    end
  end
  resources :comments
  resources :books do
    resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show] do
        resources :comments, only: [:index, :show]
      end
    end
  end
  resources :users do
    resources :posts , only: [:index, :show]
  end
   resources :posts do
     resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
