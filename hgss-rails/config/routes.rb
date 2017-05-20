Rails.application.routes.draw do
  resources :specialties
  
  resources :rescue_actions do
  	resources :areas, :controller => "rescue_action_areas"
  end

  resources :rescuers
  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
