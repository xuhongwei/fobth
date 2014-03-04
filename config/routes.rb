Fobth::Application.routes.draw do
  
  devise_for :admins
  devise_for :users, :controllers => {:omniauth_callbacks => "authentications"}
  devise_scope :user do
    get '/login'                 =>"devise/sessions#new"
    get '/logout'                =>"devise/sessions#destroy"
    get '/signup'                =>"devise/registrations#new"
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get "home/index"
  get "contact/index"

  resources :authentications
  resources :products, only: [:index,:show]
  resources :news, only: [:index,:show]
  resources :category, only: [] do
    resources :products, only: [:index] do
      get 'page/:page', :action => :index, :on => :collection
    end
  end

  root :to => "home#index"


  match "/search" => "products#search", via: [:get, :post]

  concern :commentable do
    resources :comments
  end

  resources :products, concerns: :commentable

  get 'authentications/facebook'
  post 'authentications/facebook'
  match 'users/auth/facebook/callback', to: 'authentications#facebook', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
end
