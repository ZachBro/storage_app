Rails.application.routes.draw do
  get 'search/index'
  root 'pages#home'
  get  'pages/new'
  resources :search
  resources :tickets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
