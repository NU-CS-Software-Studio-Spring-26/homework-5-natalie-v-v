Rails.application.routes.draw do
  # Define the root path ("/") to point to your todos index
  root "todos#index"

  resources :todos do
    member do
      patch :toggle_priority
      patch :snooze
    end
  end

  get '/hello', to: 'todos#hello'
  get "up" => "rails/health#show", as: :rails_health_check
end