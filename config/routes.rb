Rails.application.routes.draw do
   resources :keywords, only: [:index, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/keywords", to: "keywords#index"

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  unless defined?(::Rake::SprocketsTask)
    devise_for :users
  end

  # Defines the root path route ("/")
  root "keywords#index"
end
