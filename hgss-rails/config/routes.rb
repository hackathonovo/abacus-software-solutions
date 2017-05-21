Rails.application.routes.draw do
  get 'own_invites/index'

  resources :rescue_actions do
    resources :invites
  end
  resources :rescue_actions do
    resources :feed_items
  end
  resources :specialties
  
  resources :rescue_actions do
  	resources :areas, :controller => "rescue_action_areas" do
      resources :rescuers, :controller => "rescue_action_area_rescuers"
    end
  end

  resources :rescuers
  devise_for :users
  root to: "home#index"

  mount Autocomplete::API => '/api'
  mount Mobile::API => '/api/mobile'
end
