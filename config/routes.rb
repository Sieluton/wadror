Rails.application.routes.draw do
  get 'ratings', to: 'ratings#index'
  get 'kaikki_bisset', to: 'beers#index'
  root 'breweries#index'
  resources :beers
  resources :breweries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
