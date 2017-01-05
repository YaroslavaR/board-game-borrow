Rails.application.routes.draw do

  resources :rentals
  #get 'games_list/index'
  resources :games do
    resources :comments
  end
  get 'games_list/list'
  root 'games_list#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
