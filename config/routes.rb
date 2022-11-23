Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "dashboard", to: "pages#dashboard"

  get "/booking/:booking_id/confirm", to: "bookings#confirm", as: :confirm_booking
  get "/booking/:booking_id/decline", to: "bookings#decline", as: :decline_booking

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/api/:id", to: "api#rooms", as: :room_api
  get "/api", to: "api#all", as: :rooms_api

  resources :rooms, only: %i[show new create] do
    resources :address, only: %i[new]
    resources :bookings, only: %i[new create]
  end
end
