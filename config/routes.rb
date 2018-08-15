Rails.application.routes.draw do
  get 'search/index'
  root 'pages#home'
  get  'pages/new'
  resources :search
  resources :tickets
  post "/tickets/:id/edit" => "tickets#new_detail", :as => :create_detail
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
