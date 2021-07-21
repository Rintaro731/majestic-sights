Rails.application.routes.draw do

  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "searches#search"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows, :followers
    end
  end

  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
  end
end
