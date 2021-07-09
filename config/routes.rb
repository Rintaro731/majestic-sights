Rails.application.routes.draw do

  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "searches#search"
  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :posts do
    resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
  end
end
