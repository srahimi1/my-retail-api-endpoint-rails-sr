Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/api/v1/products/:id", to: "products#show"
  put "/api/v1/products/:id", to: "products#edit"
end