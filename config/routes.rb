Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/home", to: "home#index"

  # use_doorkeeper do
  #   skip_controllers :authorizations, :applications, :authorized_applications
  # end

  devise_for :users

  # Defines the root path route ("/")
  root "home#index"
end
