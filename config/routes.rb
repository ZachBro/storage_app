Rails.application.routes.draw do
  get 'search/index'
  root 'pages#home'
  get  'pages/new'
  get  '/current_st',  to: 'pages#current_st'
  get  '/current_rnr', to: 'pages#current_rnr'
  get  '/current_lt',  to: 'pages#current_lt'
  get  '/home',        to: 'pages#home',     as: :st
  get  '/home_rnr',    to: 'pages#home_rnr', as: :rnr
  get  '/home_lt',     to: 'pages#home_lt',  as: :lt
  resources :pages
  resources :search
  resources :tickets do
    resources :details
  end
  post "/tickets/:id" => "tickets#edit", :as => :create_detail
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
