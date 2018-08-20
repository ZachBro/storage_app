Rails.application.routes.draw do
  get 'search/index'
  root 'pages#home'
  get  'pages/new'
  get  'pages/current_st'
  get  'pages/current_rnr'
  get  'pages/current_lt'
  resources :search
  resources :tickets do
    resources :details
  end
  post "/tickets/:id" => "tickets#edit", :as => :create_detail
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
