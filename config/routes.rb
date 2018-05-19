Rails.application.routes.draw do
  resources :currencies
  devise_for :users
    root 'home#index'
	get 'home/about'
	get 'home/lookup'
	post "/home/index" => 'home/index'
end
