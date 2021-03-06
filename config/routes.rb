Rails.application.routes.draw do
  devise_for :users
  root to: 'books#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
    resources :personalizations, only: [:create]
  end

  resources :personalizations, only: [:show] do
    resources :reviews, only: [:new, :create]
    member do
      get 'show', to: 'pdfs#show', as: :show_pdf
    end
  end

  resources :filtered_books, only: :index

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  get 'dashboard', to: 'books#dashboard', as: :dashboard
  # patch '/books/:id/like', to: 'books#like', as: :like_book
  # patch 'books/:id/dislike', to: 'books#dislike', as: :dislike_book
end
