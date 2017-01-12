Rails.application.routes.draw do

  get '/rentals/my_rentals' => 'rentals#my_rentals'
  resources :rentals
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :games
  root 'games#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
