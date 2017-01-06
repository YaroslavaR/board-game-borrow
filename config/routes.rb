Rails.application.routes.draw do

  get '/rentals/my_rentals' => 'rentals#my_rentals'
  resources :rentals
  devise_for :users
  #get 'games_list/index'
  resources :games
  get 'games_list/list'
  root 'games_list#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
