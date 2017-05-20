Rails.application.routes.draw do
  resources :specialties
  
  resources :rescue_actions do
  	resources :areas, :controller => "rescue_action_areas"
  end

  resources :rescuers
  devise_for :users
  root to: "home#index"

  mount Autocomplete::API => '/api'
  mount Mobile::API => '/api/mobile'
end
