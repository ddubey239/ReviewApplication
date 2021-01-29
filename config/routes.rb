Rails.application.routes.draw do
  resources :movies do
    resources :users, only: [:index, :show] do
      member do
        get '/posts', to: 'posts#movie_user_post_index'
      end
      resources :posts, only: [:index, :show] do
        member do
          get '/comments', to: 'comments#movie_user_post_comment_index'
        end
      end
    end
  end

  resources :comments

  resources :books do
    resources :users, only: [:index, :show] do
      member do
        get '/posts', to: 'posts#book_user_post_index'
      end
      resources :posts, only: [:index, :show] do
        member do
          get '/comments', to: 'comments#book_user_post_comment_index'
        end
        # resources :comments, only: [:index, :show]
      end
    end
  end

  resources :users do
    member do
      get '/posts', to: 'posts#user_post_index'
    end
  end

   resources :posts do
     resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
