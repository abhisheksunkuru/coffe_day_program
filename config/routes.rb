Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :items do
        member do
          put 'add_to_cart'
          put 'remove_from_cart'
        end
      end
      resources :carts
    end
  end
end
